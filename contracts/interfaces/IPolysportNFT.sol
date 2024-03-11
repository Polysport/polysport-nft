// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.24;

interface IPolysportNFT {
    function mintWithNative(uint256 _mintAmount, uint256 _grade) external payable;
    function mint(uint256 _mintAmount, uint256 _grade) external;
    function burn(uint256 tokenId) external;
}