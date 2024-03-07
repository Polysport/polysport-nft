// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.24;

interface IPolysportNFT {
    function mintWithNative(uint256 _mintAmount) external payable;
    function mint(uint256 _mintAmount) external;
    function burn(uint256 tokenId) external;
}