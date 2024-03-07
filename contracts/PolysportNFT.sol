// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {ERC165} from "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {IERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import {IPolysportNFT} from "./interfaces/IPolysportNFT.sol";

contract PolysportNFT is Ownable, ReentrancyGuard, IPolysportNFT, ERC165, ERC721, ERC721Enumerable {
    using Strings for uint256;

    event NFTMinted(address indexed purchaser, uint256 indexed id);

    uint256 public tokenIdCounter;
    string public baseUri;
    uint256 public cost;
    uint256 public nativeCost;
    address payable public saleWallet;
    address public paymentToken;

    constructor(string memory _baseUri, uint256 _cost, uint256 _nativeCost, address payable _saleWallet, address _paymentToken) Ownable(msg.sender) ERC721("Polysport", "POLY") {
        baseUri = _baseUri;
        cost = _cost;
        nativeCost = _nativeCost;
        saleWallet = _saleWallet;
        paymentToken = _paymentToken;
    }

    function mint(uint256 _mintAmount) public {
        require(_mintAmount > 0);
        require(cost > 0, "Not for sale with payment token");
        uint256 totalCost = cost *_mintAmount;
        for (uint256 i = 0; i < _mintAmount; i++) {
            safeMint(msg.sender);
        }
        forwardFunds(totalCost);
    }

    function mintWithNative(uint256 _mintAmount) public payable {
        require(_mintAmount > 0);
        require(nativeCost > 0, "Not for sale with native token");
        uint256 totalCost = nativeCost * _mintAmount;
        require(msg.value >= totalCost);
        for (uint256 i = 0; i < _mintAmount; i++) {
            safeMint(msg.sender);
        }
        forwardNativeFunds(totalCost);
    }

    function safeMint(address recipient) internal nonReentrant {
        uint256 tokenId = tokenIdCounter;
        tokenIdCounter = tokenIdCounter + 1;
        _safeMint(recipient, tokenId);
        emit NFTMinted(recipient, tokenId);
    }

    function burn(uint256 tokenId) public override {
        require(_ownerOf(tokenId) == msg.sender || _getApproved(tokenId) == msg.sender);
        _burn(tokenId);
    }

    function forwardFunds(uint256 weiAmount) internal {
        IERC20(paymentToken).transferFrom(msg.sender, saleWallet, weiAmount);
    }

    function forwardNativeFunds(uint256 weiAmount) internal {
        saleWallet.transfer(weiAmount);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);
        return bytes(baseUri).length > 0 ? string.concat(baseUri, tokenId.toString(), ".json") : "";
    }

    function setBaseURI(string memory _baseUri) public onlyOwner {
        baseUri = _baseUri;
    }

    function setCost(uint256 _cost) public onlyOwner {
        cost = _cost;
    }

    function setNativeCost(uint256 _nativeCost) public onlyOwner {
        nativeCost = _nativeCost;
    }

    function setSaleWallet(address payable _saleWallet) public onlyOwner {
        saleWallet = _saleWallet;
    }

    function setPaymentToken(address _paymentToken) public onlyOwner {
        paymentToken = _paymentToken;
    }

    function supportsInterface(bytes4 interfaceId) public pure override(ERC165, ERC721, ERC721Enumerable) returns (bool) {
        return interfaceId == type(IERC721).interfaceId || interfaceId == type(IERC165).interfaceId || interfaceId == type(IPolysportNFT).interfaceId || interfaceId == type(IERC721Enumerable).interfaceId;
    }

    function _increaseBalance(address account, uint128 value) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    function _update(address to, uint256 tokenId, address auth) internal override(ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }
}
