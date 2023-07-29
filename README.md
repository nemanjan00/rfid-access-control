# RFID access control system, what it is and how to defeat it

## Description

The presentation will consist of multiple parts.

The first part will break down the architecture of the average access control system, a high-level overview of the card, reader, communication with controller and controller, and a bit about electronic locks.

The second part will get into different types of cards and readers, including readers with backward compatibility and how that can be exploited.

The third part will talk about readers talking to controllers, and usual ways readers talk to controllers, and how that can be exploited.

The fourth part will discuss common mistakes integrators and equipment manufacturers make while producing RFID access control systems and how to exploit them.

## Abstract

People attending the presentation will have the chance to try out some of the tools and see an example access control system.

While exploring the interesting world of RFID, witnessing a disappointing amount of improper implementations of access control systems, and dealing with shady vendors for backdoored cards, I realized there is a need for the proper education of people and making sure they know what to look for.

Prior knowledge about any of the topics of this presentation is optional, and it is appropriate for both beginners and someone who might already know something about this topic.

While some of the techniques and demos might look like some James Bond-level magic, most of the stuff I will be demoing and talking about can be done with pretty inexpensive equipment (you might need to spend some money if you decide to go deep into research equipment) and without much prior learning.

If you want to find more about some kind of credential, please, bring it and I will take a look at it

## Table of contents

<!-- vim-markdown-toc GFM -->

* [About me](#about-me)
* [About presentation](#about-presentation)
* [Access control system](#access-control-system)
* [Card](#card)
	* [Powering card](#powering-card)
	* [Data modulation](#data-modulation)
	* [LF cards](#lf-cards)
		* [LF card standards](#lf-card-standards)
	* [HF cards](#hf-cards)
		* [HF card standards](#hf-card-standards)
* [Controller](#controller)
* [Attacks](#attacks)
* [Extra - Privacy concerns with UHF RFID cards](#extra---privacy-concerns-with-uhf-rfid-cards)

<!-- vim-markdown-toc -->

## About me

## About presentation

Scope: 

 * RFID credentials
 
 * RFID readers
 
 * Highlevel controller overview
 
 * Integrator mistakes and problems

Out of scope: 

 * Magnetic tape
 
 * Biometrics
 
 * Plate recognition
 
 * OSDP
 
 * Business logic

## Access control system

```
Card -> Reader -> Controller -> Door
```

## Card

Unique ID

 * Different length

 * Magic cards

Power supply:

 * Active

 * Passive

Frequency:

 * LF (125kHz, 134khz)

 * HF (13.56Mhz)
 
 * UHF (300Mhz - 3Ghz) - Mostly for inventory systems, parking and tolls

### Powering card

Electromagnetic induction

### Data modulation

Load modulation

### LF cards

 * One-way communication or simple two-way communication

 * Slow communication

 * Mostly no security features

 * Simple implementations

   * Modulation

   * Baudrate

   * Inverted

#### LF card standards

 * HID Proxcard

 * EM4100

 * HiTag

 * Indala

...

 * T5577 can emulate other cards

 * EM4305 can emulate other cards

### HF cards

 * Two-way communication

 * Fast communication

 * Lower range

 * Very flexible in terms of features

 * Quite a few standards, substandards and classes of standards implementations

#### HF card standards

RF communication: ISO 14443 A, ISO 14443 B, ISO 15693, ISO 18092

Application protocols: ISO 7816 (APDU) over ISO 14443 A/ISO 14443 B, Mifare Classic, Mifare Ultralight, ISO 15693 (NFC-V)

## Controller

Input signal:

 * Wiegand

 * OSDP (out of scope)

Output signal:

 * Control the relay

 * Audiovisual feedback

## Attacks

## Extra - Privacy concerns with UHF RFID cards

Product identification by GS1 standards

 * UPC

   * Company prefix
 
   * Item reference number

 * EPC

   * Company prefix
 
   * Item reference number
 
   * Product serial number
