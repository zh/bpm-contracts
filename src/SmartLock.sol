pragma solidity ^0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";

contract SmartLock is Ownable {
    bool private _for_rent;
    address private _renter;
    // deadline = now + period parameter
    uint256 private _deadline;
    // price per hour;
    uint256 private _price;

    constructor() {
        _for_rent = true;
        _deadline = block.timestamp;
        _price = 0;
    }

    // ownership related functions

    modifier onlyRenter() {
        require(
            _renter == msg.sender,
            "SmartLock: only renter can call this function"
        );
        // This _; is not a TYPO, It is important for the compiler;
        _;
    }

    modifier beforeDeadline() {
        uint256 _now = block.timestamp;
        require(
            _now < _deadline,
            "SmartLock: only renter can call this function"
        );
        // This _; is not a TYPO, It is important for the compiler;
        _;
    }

    function forRent() external view returns (bool) {
        return _for_rent;
    }

    function rentBy() external view returns (address) {
        return _renter;
    }

    function _rent(address _user, uint256 _period) internal {
        require(_price > 0, "Smart Lock: cannot rent for nothing");
        require(
            _period >= 5 minutes && _period <= 24 hours,
            "Smart Lock: rent between 5 minutes and 24 hours"
        );
        uint256 _now = block.timestamp;
        if (_now >= _deadline) {
            _for_rent = true;
        }
        require(_for_rent == true, "Smart Lock: already rent");
        _for_rent = false;
        _renter = _user;
        _deadline = _now + _period;
    }

    function _cancel() internal {
        require(_for_rent == false, "Smart Lock: still not rent");
        _reset();
    }

    function _reset() internal {
        _for_rent = true;
        _renter = address(0);
        _deadline = block.timestamp;
    }

    function setPrice(uint256 _price_per_hour) external onlyOwner {
        require(_for_rent == true, "Smart Lock: no price changes when rent");
        _price = _price_per_hour;
    }

    function price() external view returns (uint256) {
        return _price;
    }

    function setRenter(address _user, uint256 _period) external onlyOwner {
        _rent(_user, _period);
    }

    function setForRent() external onlyOwner {
        uint256 _now = block.timestamp;
        if (_now >= _deadline) {
            _reset();
        }
    }

    function rent(uint256 _period) external payable {
        require(
            msg.value >= (_price * _period) / 3600, // price_per_hour * period_in_hours
            "Smart Lock: not enough for rent"
        );
        _rent(msg.sender, _period);
    }

    function cancel() external onlyRenter {
        _cancel();
    }

    function timeLeft() public view returns (uint256) {
        uint256 _now = block.timestamp;
        if (_now >= _deadline || _for_rent == true) {
            return 0;
        }
        return _deadline - _now;
    }

    function balanceOf() external view returns (uint256) {
        return address(this).balance;
    }

    function withdraw(uint256 amount) external onlyOwner {
        require(amount > 0, "amount of ETH must be > 0");
        uint256 exampleBalance = address(this).balance;
        require(exampleBalance >= amount, "Contract does not own enough funds");
        (bool sent, ) = payable(msg.sender).call{value: amount}("");
        require(sent, "Funds transfer failed");
    }
}
