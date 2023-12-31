# Micropayment Scheme on Aptos Blockchain

## Overview

This repository contains the decentralized implementation of a PayWord micropayment scheme using the Move language to deploy on the Aptos blockchain. The original PayWord scheme, introduced by Rivest and Shamir, required intermediary to function. Modified PayWord scheme enables decentralized, secure and cost effective micropayments.

## Features

- **Channel Creation** - A channel is created between a sender and a receiver. The sender deposits a certain amount of money and trust token into the channel. 
- **Redeem Channel** - The receiver can redeem the channel by sending last hash token provided by the sender. The channel will then send the money owed to the receiver and remaining account back to the sender.

## Tech Stack

- **Move** - Move is used to write the smart contracts for the Aptos blockchain.