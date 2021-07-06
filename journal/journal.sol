pragma solidity ^0.5.0;

contract JournalBinder{
    struct JournalEntry{
        string message;
        uint timestamp;
    }
    struct Journal{
        string Name;
        mapping(uint256 => JournalEntry) Entries;
        string JournalGoal;
        mapping(uint256 => JournalEntry) goalUpdates;
        uint256 entryCount;
        uint256 goalUpdateCount;
        uint timestamp;
    }
    struct Binder{
        mapping(uint256=> Journal) journals;
        uint createdAt;
    }
    mapping (address=>Binder) public journals;
    mapping (address=>uint256) public journalCount;

    function BURNMUJOURNAL(uint256 index)public returns(bool){
        delete journals[msg.sender].journals[index];
        return true;
    }
    function addEntry(string memory message,uint256 index)public{
        Journal storage journal =journals[msg.sender].journals[index];
        journal.Entries[journal.entryCount]= JournalEntry(message,block.timestamp);
        journal.entryCount++;
    }
    function addGoalEntry(string memory message,uint256 index)public{
        Journal storage journal =journals[msg.sender].journals[index];
        journal.goalUpdates[journal.entryCount]= JournalEntry(message,block.timestamp);
        journal.goalUpdateCount++;
    }
    function newJournal(string memory goal,string memory name) public{
        Journal memory journal = journals[msg.sender].journals[journalCount[msg.sender]];
        journal.JournalGoal= goal;
        journal.Name=name;
        journal.timestamp= block.timestamp;
        journalCount[msg.sender]++;
    }
    function getJournalName(uint256 index) public view returns(string memory){
        return journals[msg.sender].journals[index].Name;
    }
    function getJournalEntry(uint256 jIndex,uint256 eIndex)public view returns(string memory, uint256 timestamp){
        Journal storage journal =journals[msg.sender].journals[jIndex];
        return (journal.Entries[eIndex].message,journal.Entries[eIndex].timestamp);
    }
    function getGoalEntry(uint256 jIndex,uint256 eIndex)public view returns(string memory, uint256 timestamp){
        Journal storage journal =journals[msg.sender].journals[jIndex];
        return (journal.goalUpdates[eIndex].message,journal.Entries[eIndex].timestamp);
    }
    function getJournalGoal(uint256 index) public view returns(string memory){
        return journals[msg.sender].journals[index].JournalGoal;
    }
    /**
    * #functionalities journal
    * *create journal
    * *create entry
    * *create goal entry
    * *burn journal
    * *
    */

}