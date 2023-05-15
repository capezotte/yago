#ifndef	_SYS_ELFDEFINITIONS_H_
#define	_SYS_ELFDEFINITIONS_H_

#include <elf.h>

/**
 ** Missing ELFtoolchain types from musl.
 **/

typedef uint8_t		Elf32_Byte;	/* Unsigned tiny integer. */
typedef uint64_t	Elf32_Lword;	/* Unsigned long integer. */

typedef uint8_t		Elf64_Byte;	/* Unsigned tiny integer. */
typedef uint64_t	Elf64_Lword;	/* Unsigned long integer. */

/*
 * Capability descriptors.
 */

/* 32-bit capability descriptor. */
typedef struct {
	Elf32_Word	c_tag;	     /* Type of entry. */
	union {
		Elf32_Word	c_val; /* Integer value. */
		Elf32_Addr	c_ptr; /* Pointer value. */
	} c_un;
} Elf32_Cap;

/* 64-bit capability descriptor. */
typedef struct {
	Elf64_Xword	c_tag;	     /* Type of entry. */
	union {
		Elf64_Xword	c_val; /* Integer value. */
		Elf64_Addr	c_ptr; /* Pointer value. */
	} c_un;
} Elf64_Cap;

/*
 * Note descriptors.
 */

typedef	struct {
	uint32_t	n_namesz;    /* Length of note's name. */
	uint32_t	n_descsz;    /* Length of note's value. */
	uint32_t	n_type;	     /* Type of note. */
} Elf_Note;

/* 64 bit RegInfo entry. */
typedef struct {
	Elf64_Word	ri_gprmask;  /* Mask of general register used. */
	Elf64_Word	ri_pad;	     /* Padding. */
	Elf64_Word	ri_cprmask[4]; /* Mask of coprocessor register used. */
	Elf64_Addr	ri_gp_value; /* GP register value. */
} Elf64_RegInfo;

/*
 * The header for GNU-style hash sections.
 */

typedef struct {
	uint32_t	gh_nbuckets;	/* Number of hash buckets. */
	uint32_t	gh_symndx;	/* First visible symbol in .dynsym. */
	uint32_t	gh_maskwords;	/* #maskwords used in bloom filter. */
	uint32_t	gh_shift2;	/* Bloom filter shift count. */
} Elf_GNU_Hash_Header;

#endif	/* _SYS_ELFDEFINITIONS_H_ */
