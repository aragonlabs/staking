# Staking App

This is just a research excercise, but hopefully it'll be fruitful.

## Goals

- A primitive staking app that can be used in the ACL to govern other things in Aragon
- Be flexible enough to implement token-curated registries with the voting app and the [registry app](https://github.com/aragonlabs/registry)
- Identify potential issues with current aragonOS architecture for apps that require "fallback" transactions, i.e. transactions when something *does not occur*.

## Issues

- When the staking app forwards, how do we determine if the person sending the original transaction is voting for A or B?
- When e.g. a vote fails, how do we "call back" to the staking app in order to transition the state correctly? (Either A wins or B wins)
- How do we determine pool IDs such that transactions with different call scripts contain the correct pool ID? For example, suppose someone stakes to start a vote (callscript with hash `0xabc`), and then someone stakes to vote in that voting (callscript with hash `0xdef`). The pool IDs for both transactions should match, such that a new staking pool is not created.
- How do we adjust the weight of e.g. votes according to the amount of staked tokens?

## Glossary

- **Stake pool**: A pool of funds that are logically similar (e.g. stakes for a vote *A* should be in the same pool, but in a different pool from vote *B*).

## Token Curated Registries

The primary idea is that this app could be used to create token curated registries.  
  
Install this app, the registry app and the voting app in your organisation. The only entity that can add/remove entries to/from the registry is the voting app, and the only entity who can create votes and vote in votes is the staking app.  
  
The only entity that can transition pool states is the voting app, too.  
  
Tada! :tada:

## Team

Advisors: Santa Claus, Jesus Christ, Moses
ICO: 2030
