# KAIST Thesis Template

## Usage

1. clone the git repo:
  ```
  $ git clone git@github.com:0xdkay/kaist-thesis-template.git
  ```

2. build it:
  ``` sh
  $ make

  (check p.pdf)
  ```

3. starting point, p.tex:
  ```
  $ grep -oP 'input{\K\w+' p.tex
  macro
  abstract
  intro
  back
  anal
  accounting
  attack
  cm
  related
  concl
  summary
  ack
  cv
  ```

### Original Format
  ```
  https://github.com/tsgates/die
  ```

### Index
Abstract

1. Introduction

2. Overview of VoLTE
  1. Cellular network architecture
  2. Voice service over LTE network
    - Signaling flow in LTE network, Bearer concept
    - Call session mangaement (Register, INVITE flow )
    - Dual stack implementation of VoLTE in devices (AP, CP)

  3. VoLTE accounting policy
    - Time-based charging.
    - Unlimited talk within same operator network

3. Problems in current VoLTE service
  1. Analysis of VoLTE call
    1. Analysis of call flow
    2. Analysis of media channel
  2. Hidden data channels
    1. Direct communication
    2. SIP tunneling
    3. Media tunneling
  3. Other threats
    - UE
    - P-GW
    - IMS
  4. Goal & Threat model
    - Goal
    - Threat model

4. Exploiting hidden data channels
  2. Implementation
    1. Sending module
    2. Receiving module
  3. Measurement (Evaluation)
    - channel measurement result

5. Exploiting VoLTE mis-implementation
  1. Vulnerability in UE
    1. Permission model mismatch
      - Denial of Call
      - Overbilling
  2. Vulnerability in P-GW
    1. Direct Communication
      - Free Video Call
      - Call Spoofing
  2. Vulnerability in IMS
    1. No Authentication
      - Call Spoofing
