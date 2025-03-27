// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    function run() external returns (MoodNFT) {
        string memory sadSvg = vm.readFile("./images/dynamicNft/sad.svg");
        string memory happySvg = vm.readFile("./images/dynamicNft/happy.svg");

        vm.startBroadcast();
        MoodNFT moodNFT = new MoodNFT(svgToImgUri(sadSvg), svgToImgUri(happySvg));
        vm.stopBroadcast();
        return moodNFT;
    }

    function svgToImgUri(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
