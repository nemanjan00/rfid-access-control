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
* [Card (ass grab tech)](#card-ass-grab-tech)
    * [Powering card - Electromagnetic induction](#powering-card---electromagnetic-induction)
    * [Command modulation](#command-modulation)
    * [Data modulation - Load modulation](#data-modulation---load-modulation)
    * [Figuring out the frequency](#figuring-out-the-frequency)
    * [LF cards](#lf-cards)
        * [LF card standards](#lf-card-standards)
        * [Vulnerabilities and characteristics](#vulnerabilities-and-characteristics)
        * [Tools](#tools)
    * [HF cards](#hf-cards)
        * [Vulnerabilities and characteristics](#vulnerabilities-and-characteristics-1)
        * [HF card standards](#hf-card-standards)
        * [Tools](#tools-1)
    * [UHF cards](#uhf-cards)
* [Controller](#controller)
    * [Wiegand](#wiegand)
* [Attacks](#attacks)
    * [Hardcoded/default credentials](#hardcodeddefault-credentials)
    * [Fuzzing attacks](#fuzzing-attacks)
    * [Controller and reader combo attacks](#controller-and-reader-combo-attacks)
* [Extra - Privacy concerns with UHF RFID cards](#extra---privacy-concerns-with-uhf-rfid-cards)
* [About the community](#about-the-community)

<!-- vim-markdown-toc -->

## About me

 * nemanjan00
 
 * I like to take things apart
 
 * Sometimes put them back togetger
 
 * Reverse Engineering, RND and DevOps @ Constallation

## About presentation

Scope: 

 * RFID credentials
 
 * RFID readers
 
 * Highlevel controller overview
 
 * Integrator and manufacturers mistakes and problems

Out of scope: 

 * Magnetic tape
 
 * Biometrics
 
 * Plate recognition
 
 * OSDP
 
 * Business logic

## Access control system

![](images/architecture.png)

## Card (ass grab tech)

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

### Powering card - Electromagnetic induction

Current gets induced in one of these cases:

 * Conductor moves in constant field

 * Conductor is in alternating field

How is this used?

 * Sinusoid signal at proper frequency (125kHz for example)

 * Resonant antenna

   * Antenna length depends on wavelength (length light travels during one oscilation)

   * Lower frequency, bigger antenna

### Powering card showcase

![](images/scope_screenshot.png)

### Command modulation

 * Capacitor can be used to store power

 * Sine cycles can be skipped, to modulate data (commands)

### Data modulation - Load modulation

 * Load on card = Load on power source

 * Increase in load = Decrease in voltage

 * It can be measured across both antennas

 * It can be measured in field (sniffing)

 * Switching load on and off can be used for modulation

### Figuring out the frequency

 * Flashlight (antennas do not look the same)

 * Field detector

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

 * ISO 11784 / 11785 Standard - Animal chips

#### Vulnerabilities and characteristics

 * Trivial to read

 * Trivial to clone or emulate

 * Requires big antennas for great performance, due to low frequency

#### Tools

|Tool|Read|Write|Emulate|Note|
|-|-|-|-|-|
|Proxmark3|✔|✔|✔|Low level implementation|
|White cloner|✔|✔|❌|No display for ID|
|Blue cloner|✔|✔|❌|Sets password|
|Tinylabs Keysy|✔|✔|✔|Closed source|
|Chameleon Ultra|✔|✔|✔|Only EM4100 right now|
|Flipper Zero|✔|✔|✔|Great support|

### HF cards

 * Two-way communication

 * Fast communication

 * Very flexible in terms of features

 * Quite a few standards, substandards and classes of standards implementations

 * Some standards support anti-collision

#### Vulnerabilities and characteristics

 * More advanced modulation techniques

 * Proprietary communication protocols

 * Sometimes encrypted

 * Sometimes programmable (Java SmartCard)

 * Readers do not always use proprietary features and sometimes rely on low level stuff like UID)

 * Can be cloned, but relies on understandind the tech implemented in a card

 * Higher frequency means smaller performant antennas = long range cloning (few 10s of cm)

#### HF card standards

RF communication: ISO 14443 A, ISO 14443 B, ISO 15693, ISO 18092

Application protocols: ISO 7816 (APDU) over ISO 14443 A/ISO 14443 B, Mifare Classic, Mifare Ultralight, ISO 15693 (NFC-V)

Implementations either extend existing command set or utilize ISO 7816 (APDU) over underlaying protocols.

#### Tools

 * Proxmark3

 * Chameleon Mini (Tiny)

 * Chameleon Ultra

 * Flipper Zero

 * Long range readers

 * PN532 (libNFC)

 * DL533N (libNFC)

### UHF cards

ISO 18000

Unique ID is called TID

Has readable memory

## Controller

Input signal:

 * Wiegand

 * OSDP (out of scope)

Output signal:

 * Control the relay

 * Audiovisual feedback

### Wiegand

![](images/logic_photo.jpg)

![](images/logic_screenshot.png)

#### Wiegand to ID

![](images/logic_decoded_screenshot.png)

## Attacks

 * Cloning credentials

 * Hardcoded/default credentials

 * Fuzzing attacks

 * Downgrade attacks

 * Crypto or PRNG implementation attacks (for example nested, hardnested and darkside attacks on Crypto1)

 * Wiegand sniffing and replay

 * Controller and reader combo attacks

### Hardcoded/default credentials

 * Some controllers come with default credentials hardcoded

 * There are backdoor credentials

 * Some of them have been leaked (No security by obscurity)

### Fuzzing attacks

 * There have been cases where readers did unlock for some extreme values

 * 0x00000000

 * 0xffffffff

### Controller and reader combo attacks

 * Default password can be used to register new credentials

 * Push to unlock button is on the outside

   * Signal wire is connected to VCC using pull up resistor

   * Button connects signal wire to ground

   * When voltage falls below certain value, relay is connected, to unlock

   * Color scheme for wiring is well known

 * Relay is on the outside

   * Relay = Electromagnet connected to metal plate and metal plate on spring

   * External magnetic field can activate relay

## Extra - Privacy concerns with UHF RFID cards

Product identification by GS1 standards

 * UPC

   * Company prefix
 
   * Item reference number

 * EPC

   * Company prefix
 
   * Item reference number
 
   * Product serial number

## About the community

 * Iceman Discord (1$ donation)
 
 * Abstract Security Discord
 
 * RRG Github

