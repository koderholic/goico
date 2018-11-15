pragma solidity ^0.4.25;


contract SafeMath {
    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function safeMul(uint a, uint b) public pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

contract ERC20Standard {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}


contract Owned {
    address public owner;
    address public newOwner;

    event OwnershipTransferred(address indexed _from, address indexed _to);

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        newOwner = _newOwner;
    }
    function acceptOwnership() public {
        require(msg.sender == newOwner);
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
        newOwner = address(0);
    }
}


contract DiginexToken is ERC20Standard, Owned, SafeMath {
    string public symbol;
    string public  name;
    uint8 public decimals;
    uint public _totalSupply;
    uint public _maxTotalSupply;
    uint public startDate;
    uint public endDate;
    uint public endVestingPeriod;
    
    
    mapping(address => bool) vesting;
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;


    constructor() public {
       
        symbol = "JFT";
        name = "Justice Fund Token";
        decimals = 18;
        _maxTotalSupply = 1000000*(10**uint(decimals));
        startDate = now;
        endDate = now + 2 weeks;
        endVestingPeriod = now + 24 weeks;
        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() public constant returns (uint) {
        return _totalSupply - balances[address(0)];
    }

    function balanceOf(address tokenOwner) public constant returns (uint balance) {
        return balances[tokenOwner];
    }


    function transfer(address to, uint tokens) public returns (bool success) {
        require(vesting[msg.sender] == false || now >= endVestingPeriod);
        
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function approve(address spender, uint tokens) public returns (bool success) {
        require(vesting[msg.sender] == false || now >= endVestingPeriod);
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }


    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        balances[from] = safeSub(balances[from], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(from, to, tokens);
        return true;
    }

    function allowance(address tokenOwner, address spender) public constant returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }


    function approveAndCall(address spender, uint tokens, bytes data) public returns (bool success) {
        require(vesting[msg.sender] == false || now >= endVestingPeriod);
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        approveAndCallFallBack(spender).receiveApproval(msg.sender, tokens, this, data);
        return true;
    }

    function () public payable {
        require(now >= startDate && now <= endDate);
        uint tokens;
        
        tokens = msg.value * 1000000; //1 token = 0.000001 ETH
        _totalSupply = safeAdd(_totalSupply, tokens);
        
        require(_totalSupply <= _maxTotalSupply); //1,000,000 tokens Max
        
        balances[msg.sender] = safeAdd(balances[msg.sender], tokens);
        emit Transfer(address(0), msg.sender, tokens);
        owner.transfer(msg.value);
    }
    

    function addVestingAddress(address user) public returns (bool success) {
        require (msg.sender == owner);
        vesting[user] = true;
        return true;
    }


    function transferAnyERC20Standard(address tokenAddress, uint tokens) public onlyOwner returns (bool success) {
        return ERC20Standard(tokenAddress).transfer(owner, tokens);
    }
}

contract approveAndCallFallBack {
    function receiveApproval(address from, uint256 tokens, address token, bytes data) public;
}
