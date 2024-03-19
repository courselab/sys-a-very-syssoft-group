dnl    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
dnl   
dnl    SPDX-License-Identifier: GPL-3.0-or-later
dnl
dnl    This file is part of SYSeg, available at https://gitlab.com/monaco/syseg.

divert(-1)

changequote(`[',`]')

dnl Some global definitions.

define([DOCM4_PROJECT],[SYSeg])
define([DOCM4_REPOSITORY],[http://gitlab.com/monaco/syseg])
define([DOCM4_YEAR],[2001])
define([DOCM4_AUTHOR],[Monaco F. J. <monaco@usp.br>.])
define([DOCM4_EMAIL]),[<monaco@usp.br>])
define([DOCM4_LICENSE],[GNU General Public License vr.3])
define([DOCM4_LICENSE_SHORT],[GNU GPL vr.3 or later])

define([TOOL_PATH],_TOOL_PATH)

define([DOCM4_DEPS],_TOOL_PATH/docm4.m4 TOOL_PATH/bintools.m4)]

dnl A short head notice that can be used in the README file
dnl describing the contents of a directory.

define(DOCM4_DIR_NOTICE,
[
dnl   The contents of this directory are part of DOCM4_PROJECT,
dnl   available at DOCM4_REPOSITORY
])


define(DOCM4_HASH_HEAD_NOTICE,)

define([DOCM4_BINTOOLS],
[changecom(,)dnl
## Bintools: convenience rules for inspecting binary files
##
## SYSeg's Bintools is a collection of Makefile rules aimed as shortcut for
## invoking binary inspection utilities. It contains handy Make rules for
## disassembling objects, comparing files, creating bootable images, invoking
## platform emulators and other facilities. Some shortcuts are ad hoc rules
## crafted under poetic license and may depart from conventional Make usage.
include(bintools.m4)
changecom([#],)dnl

# End of MakeBintools.
# -------------------------------------------------------------
])

define([DOCM4_INSTRUCTIONS],
[

 Instructions
 ------------------------------

 The code examples in this directory include explanatory comments annotated
 directly in the source file comments. Those notes are complemented by the
 additional technical discussions provided in this README file.
 
 While some examples may be independent one from another, there may be also
 sequences of code snippets in which each example builds on its predecessor.
 In those cases, it may be interesting to go through the code examples in the
 same order they are introduced in the present README.
 
 For convenience, a build script (e.g. Makefile) may be provided which contains
 rules to compile, execute and inspect the contents of the source and object
 the examples are built and executed.
])


# define([DOCM4_UPDATE_AUTHOR_INFO],
# [
#   Please, *do not* forget to

#     - create a file AUTHORS and edit it with your name
#     - edit heading comments in all source files with your data

#   Open-Source literacy time:

#   Every source file of SYSeg contains a copyright and licensing statement. 

#   But remember: the authorship of your own source code --- even if you borrow
#   parts of SYSeg --- should be assigned to you, the author of your work; not
#   to the original SYSeg author(s). Nevertheless, being your source code a
#   derivative work of SYSeg, credits are due to SYSeg author(s), whence
#   making a propper attribution to SYSeg is order.
  
#   Also, bear in mind that the SYSeg's licence requires your derivative
#   work to be distributed under terms no more restrictive than those enforced
#   by the license of the original work --- if in doubt, keeping the original
#   SYSeg licence is perfectly safe.

#   One way to claim the copyright of your derivative work and attribute credits
#   to the original work is by adding the following notice at the top of every
#   source file of your project (e.g. keeping the original DOCM4_PROJECT
#   license):

#   The 'make export' rule of the script will do all that for you.
#   Just edit the empty fields.
  
# ])



dnl
dnl Bintools documentation
dnl


define([DOCM4_BINTOOLS_DOC],
[

 Bintools: convenience rules for inspecting binary files
 ------------------------------------------------------------
 
 SYSeg's Bintools is a collection of Makefile rules aimed as shortcut for
 invoking binary inspection utilities. It contains handy Make rules for
 disassembling objects, comparing files, creating bootable images, invoking
 platform emulators and other facilities. Some shortcuts are ad hoc rules
 crafted under poetic license and may depart from conventional Make usage.

 CONVENTIONS AND CONVENIENCES
 
 As a rule of thumb, a file named

     foo.bar            contains the working implementation
     foo-beta.ext	contains working but cumbersome/inelegant implementation
     foo-alpha.ext	contains incomplete or wrong implementation

 File extensions:

     hex		ASCII file containing values
     			in hexadecimal representation;

     asm		manually written assembly code in
     			Intel ASM format;

     S			manually written assembly code
     			in AT&T Gas format;

     s			assembly code in AT&T Gas format
     			generated by the compiler (GCC);

     o			object code produced by the assembler;

     bin		binary file generated by the
     			linker;

     ld			linker script.

 Some examples allow alternative build recipes which can be selected
 by passing the command-line variable ALT=<number> to 'make'. See bellow.

 NEEDED SOFTWARE

 In order to experiment with the examples in this section, the following
 pieces of software may be needed. The version indications list those with
 which the project was tested. Using a more recent version should be
 ok, but it is not absolutely guaranteed that results won't exhibit minor
 variations. Feedback is always appreciated.

 If required for a particular example, it is safe to use

 - Linux         5.13.0         (any decent ditribution)
 - GCC 	     	 9.3.0	        (the GNU compiler)
 - GNU binutils  2.34		(GNU assembler, linker, disassembler etc.) 
 - nasm		 2.14.02	(NASM assembler)
 - qemu		 4.2.1		(most probably qemu-system-i386)
 - gcc-multilib  9.3.0		(to compile 32-bit code in a 64-bit platform)
 - xorriso	 1.5.2-1	(depending on your computer's BIOS)
 - hexdump	 POSIX.2	(binary editor)
 
 CONVENIENCY RULES 


 * For buiding and inspecting, use

   make					     Build the default target.

   make foo				     Build foo.

   make diss IMG=foo 			     Disassemble foo.

   	     	     			     Optionally,

					        ASM  = intel | att  (default)
						BIT  =    16 | 32   (default)

   make dump IMG=foo			     Show the raw contents of foo.
   
   make      			             Build everything (or make all)

   make clean			             Undo make all

   make diff foo bar baz		     Show graphical diff between files

   	     	     			     ASM and BIT variables apply


  * If any example involves the manipulation of a bootable image, use
  

   make run IMG=foo	             	     Run foo in the emulator

   make stick IMG=foo DEVICE=/dev/sdX        make a bootable USB stick


   SHORTCUTS

   For further convenience, the build script offers some ad hoc shortcuts:
   

   make foo/diss | foo/d		     disassemble .text as 32-bit AT&T

   make foo/diss intel|att		     disassemble as 32-bit Intel or AT&T
   make foo/diss 16|32			     disassemble as 16-bit or 32-bit
   make foo/diss intel|att 16|32	     disassemble as Intel|AT&T 16|32 bit
   make foo/diss 16|32 intel|att	     disassemble as Intel|AT&T 16|32 bit

   make foo/i16	       			     disassemble as Intel 16-bit
   make foo/a16 | foo/16  		     disassemble as AT&T  16-bit
   make foo/a32	| foo/32 | foo/a     	     disassemble as AT&T  32-bit
   make foo/i32	         | foo/i	     disassemble as Intel 32-bit

   		   			     In all disassembly rules, a
					     trailing '*' means disassemble all
					     sections, e.g. foo/d* foo/16* ...

   make foo/hex | foo/raw | foo/dump	     show raw contents in hexadecimal

   make foo/run				     test foo (mbr) with the emulator
   make foo/fd				     test foo (floppy) with the emulator

   make diffi16 | di16 | i16 foo bar baz     make diff with ASM=intel BIT=16
   make diffi32 | di32 | i32 foo bar baz     make diff with ASM=intel BIT=32
   make diffa16 | da16 | a16 foo bar baz     make diff with ASM=att BIT=16
   make diffa32 | da32 | a32 foo bar baz     make diff with ASM=att BIT=32

   make foo/stick dev    	   	     make stick IMG=foo DEVICE=dev

 ])

define([DOCM4_BOOT_NOTE],
[

   NOTE ON BOOTING THE REAL HARDWARE

   If any example involves booting the physical hardware from a USB stick
   through the BIOS legacy boot mode, mind the following note.

   Unfortunately, not all BIOSes  handle USB boot devices in the same
   way (welcome to system level). Some are likely to emulate it as a floppy
   disk and rely on the original IBM PC boot method (a.k.a legacy boot).
   If so, you should be able to prepare your stick using 'make stick foo.bin'
   Otherwise, if your computer's BIOS emulates your USB stick as a CD-ROM,
   you should be better served by evoking 'make foo.iso'. This recipe will
   create an ISO-9660 CD image with El Torito extension, which is suitable
   for bootable CDs (you will still boot the stick but as if it were a CD). 

   Be aware also that some BIOSes assume the the boot media contains a volume
   boot record (VBR) entry (i.e. that the media is formatted as FAT file
   system). This being your case, if your boot image is not FAT-formatted,
   your program may not boot or, even worse, it may indeed boot, but then
   execute with errors. If that happens, you may try to fake a VBR by
   rewriting your code so that the binary image starts with the byte sequence
   0xeb Ox3c, followed by a sequence of 61 bytes 0x90; that should suffice
   to appease most idiosyncratic BIOSes (apropos, that leading 0xeb 0X3c
   sequence is an instruction that jumps to the beginning of your actual
   boot code, just after the fake VBR.

   Finally, notice that not all modern BIOS support legacy boot emulation.
   If your BIOS is one of those, you may still test your program using the
   emulator, or else try another computer equipment.

   *** Words of wisdom ***

   If you plan to boot the examples in the physical hardware, check which
   device represents your USB stick. You may use, for instance lsblk utility
   for that. Your devices should possibly list as /dev/sdX,
   with X being a, b, c etc.

   If you have only one storage device, say your HD, it may appear as
   /dev/sda; when you plug your USB stick, it'll probably take the next
   available letter and appear as /dev/sdb. As a measure of caution, you
   may run lsblk both with and without your USB stick plugged in, and
   take notice of which device differs in both listings. You should be
   required administrative privileges (sudo) to write directly into your
   device.

   BE CAREFUL:  Forewarned is forearmed!

   If you have your HD as /dev/hda and you accidentally misspell your
   stick device as /dev/hda instead of /dev/hdb, you may end up finding
   yourself grieving in pitiful misery and hopeless regrets...
   you can't be too careful when playing at system level.

   Note: in some systems, storage device may also appear as /dev/mmcblk;
   e.g. /dev/mmcblk0p1 is the first partition of the device mmcklk0.

 ])

##
## Have a good coding
##
define([DOCM4_CLOSING_WORDS],
[
  Good coding.
])

##
## Update Makefile from Makefile.m4
##
define([UPDATE_MAKEFILE],
[
# Update Makefile from Makefile.m4 if needed, and then invoke make again.
# If the source is from a pack-distribution, the lack of Makefile.m4
# inhibits the updating. 

ifndef UPDATED

Makefile_deps = Makefile.m4 DOCM4_DEPS

Makefile : $(shell if test -f Makefile.m4; then echo $(Makefile_deps); fi);
	@if ! test -f .dist; then\
	  cd .. && make;\
	  make -f Makefile clean;\
	  make -f Makefile UPDATED=1 $(MAKECMDGOAL);\
	fi

endif
])

##
## Programing exercise directions with pack
##
define([DOCM4_EXPORT_DIRECTIONS],
[
 Directions for the exercise
 ------------------------------

 Within the exrcise directory, invoke the make rule

    $ make export             

 This should create a tarball containing the project files.
 Copy it to your own project tree and uncompress the tarball.

 To complete the programming exercise, proceed as indicated
 in both this file and the example source code.

 **Attention** do not simply copy the SYSeg files to your project.
 
     Some programs, build scrips, configuration files etc. may be
     heavily dependent on other parts of SYSeg and have not being
     designed to work properly if not in conjunction with those
     other files. If you merely copy files, they may well be incomplete.
     The syseg-export program should be used to export the SYSeg code
     into a standalone bundle. The above make rule will collect the
     required files, and possibly modify them as needed to work outside
     the SYSeg project tree. Moreover, syseg-export will also modify
     the copyright statement in a form suitable for a derivative work.

  Should you intend to reuse any other file from SYSeg, please use
  the command

     $ syseg-export <input-file> <output-directory>

  found in the directory syseg/tools. It will export SYSeg files
  in a format suitable to be reused by external projects.

DOCM4_UPDATE_AUTHOR_INFO
])

define([DOCM4_DELIVERY_DIRECTIONS],
[
  How to deliver the exercise
  ------------------------------
  
  If you're exploring the exercise as part of a trainning program,
  chances are that your instructor is following the delivery workflow
  suggested by SYSeg. If that is the case, when you're done with the
  activity, you should be asked to upload your work into a repository
  managed by a version-control system (VCS) --- most probably Git.

  For this purpose, you must have already created your online repository
  in the recommended platform (e.g. GitHub or GitLab).

  To deliver your programming exercise just commit your changes and push
  them into to the mainstream repository.

  You may commit partial changes even before completing the exercise. That
  may be a convenient way to share ideias and ask for help.

  When you belive your work is complete, mark your final revision with a
  tag. Each exercise should specify a delivery tag. For instance, if the
  exercise specifies the tag 'foo', proceed as follows

     $ git tag foo
     $ git push origin foo

  The instructor will know you are finished with the exercise.

  If further changes are required, please use 'foo.1', 'foo.2' etc.

  Note: please, unless otherwise explicitly specified, commit only source
  files (don't commit object or executable files). Usually, the exercise
  specification will list the required files.

  Please stick to the following convention:

  - Unless otherwise specified, create a subdirectory under the root of
    your project tree with the same name as the exercise. For instance,
    if you are working on exercise `syseg/try/bar`, create a subdirectory
    `bar` at the root of your project directory.

  - If a delivery tag is not specified, use the name of the current directory,
    i.e., if the exercise is within 'ssyseg/try/baz', use the tag 'baz'.



])

# Shortcut for export and delivery directions.

define([DOCM4_EXERCISE_DIRECTIONS],

[DOCM4_EXPORT_DIRECTIONS]
[DOCM4_DELIVERY_DIRECTIONS]
)

##
##
##
define([DOCM4_RELEVANT_RULES],
[changecom(,)
###########################################################
##
## These are the rules of interest in this set of examples.
##
changecom([#],)
])

##
## Create pack-distribution (subprojects).
##
define([DOCM4_EXPORT],
[changecom(,)
# Self-contained pack distribution.
#
# make syseg-export     creates a tarball with the essential files, which
#       	        can be distributed independently of the rest of
#			this project.
#
# A pack distribution contain all the items necessary to build and run the
# relevant piece of software. It's useful,a for instance, to bundle
# self-contained subsections of DOCM4_PROJECT meant to be delivered as
# programming exercise assignments or illustrative source code examples.
#		
# In order to select which files should be included in the pack, list them
# in the appropriate variables
# 
# EXPORT_FILES_C    = C files (source, headers, linker scripts)
# EXPORT_FILES_MAKE = Makefiles
# EXPORT_FILES_TEXT = Text files (e.g. README)
# EXPORT_FILES_SH   = Shell scripts (standard /bin/sh)
#
# Except by text files, all other files will have their heading comment
# (the very first comment found in the file) replaced by a corresponding
# standard comments containing boilerplate copyright notice and licensing
# information, with blank fields to be filled in by the pack user.
# Attribution to DOCM4_PROJECT is also included for convenience.

TARNAME=$1-$2

changecom([#],)

syseg-export export:
	@if ! test -f .dist; then\
	  make do_export;\
	 else\
	  echo "This is a distribution pack already. Nothing to be done.";\
	fi

do_export:
	rm -rf $(TARNAME)
	mkdir $(TARNAME)
	(cd .. && make clean && make)
	for i in $(EXPORT_FILES); do\
	  TOOL_PATH/syseg-export $$i $(TARNAME);\
	done
	touch $(TARNAME)/.dist
	tar zcvf $(TARNAME).tar.gz $(TARNAME)

clean-export:
	rm -f $(TARNAME).tar.gz
	rm -rf $(TARNAME)

.PHONY: syseg-export export clean-export

])

## Template for binary and library build using GNU make and gcc capabilities.
## These rules makes use of GNU extensions and are not fully portable.
## The code exceprt if part MAKEGYVER, part [DOCM4_PROJECT].
define([DOCM4_MAKEGYVER],[
## ----------------------------------------------------------------------
## This piece of code is part of MakeGyver.
##
include(Makegyver.mk)

## End of MakeGyver
## ----------------------------------------------------------------------
])
divert(0)dnl
