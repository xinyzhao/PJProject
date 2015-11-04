## PJProject

<b>This is a PJSIP multi-arch building scripts for iOS.</b>

### About PJSIP

<p>PJSIP is a free and <a HREF="http://www.pjsip.org/about.htm#opensource">open source</a> multimedia communication library written in C language  implementing standard based protocols such as SIP, SDP, RTP, STUN, TURN, and ICE. It combines signaling protocol (SIP) with rich multimedia framework and NAT traversal functionality into high level API that is portable and suitable for almost any type of systems ranging from desktops, embedded systems, to mobile handsets.</p>
 	
<p>PJSIP is both <a HREF="http://www.pjsip.org/about.htm#compact">compact</a> and <A HREF="http://www.pjsip.org/about.htm#comprehensive">feature rich</A>. It supports audio, video, presence, and instant messaging, and has extensive <a HREF="http://www.pjsip.org/about.htm#documentation">documentation</a>. PJSIP is <A HREF="http://www.pjsip.org/about.htm#portable">very portable</A>. On mobile devices, it abstracts system dependent features and in many cases is able to utilize the native multimedia capabilities of the device.</p>

<p>PJSIP has been developed by <a HREF="http://www.pjsip.org/about.htm#who">a small team</a> working exclusively for the project since <a HREF="http://www.pjsip.org/about.htm#history">2005</a>, with participation of hundreds of developers from around the world, and is routinely tested at SIP Interoperability Event (<A HREF="http://www.sipit.net">SIPit </A>) since 2007.</p>

<p><b>More <A HREF="http://www.pjsip.org/about.htm">about PJSIP </A></b></p>

### Building the PJSIP

1. Download and copy the `build.sh` to PJSIP root directory.
2. To generate the multi-arch lib, simply invoke:
        
    sh build.sh [dir]
        
**The resulting LIB is located in `lib/`(default) or `dir/`(input) root directory.**

### Built architectures

4 architectures currently exists on iOS:

- 64 bits ARM64 for iPhone 5s, iPad Air, iPad mini 2, iPhone 6, iPhone 6 Plus, iPad Air 2, iPad mini 3.
- 32 bits ARMv7 for older devices.
- 64 bits x86_64 for simulator for all ARM64 devices.
- 32 bits i386 for simulator for all ARMv7 older devices.

### Licensing

The building scripts is available under the MIT license. See the LICENSE file for more info.
