// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "/contracts/SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract () public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function fsStore (uint256 _simpleStorageIndex, uint256 _simpleStorgeNumber) public {
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorgeNumber);
    }

    function sfGet (uint256 _simpleStorageIndex) public view returns (uint256) {
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}