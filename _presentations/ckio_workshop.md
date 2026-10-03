---
layout: distill
title: "CkIO: Parallel File Input for Over-Decomposed Task-Based Systems"
description: "Mathew Jacob, Maya Taylor. Workshop talk on scalable parallel file input for asynchronous many-task runtimes, presented by Maya Taylor."
category: research
date: 2024-04-16
venue: "16th JLESC Workshop, RIKEN R-CCS, Kobe, Japan"
img: /assets/img/publication_preview/ckio_diagram.png
slides: https://mayantaylor.github.io/presentations/CkIO_JLESC.pdf
pdf: /assets/pdf/papers/ckio_pdf.pdf
importance: 2
---

A talk at the 16th [Joint Laboratory for Extreme-Scale Computing](https://jlesc.github.io/) workshop on CkIO, delivered by my collaborator [Maya Taylor](https://mayantaylor.github.io/). CkIO is a parallel input library for [Charm++](https://charm.cs.illinois.edu/), developed in the [Parallel Programming Laboratory](http://charm.cs.uiuc.edu/) at UIUC with Professor Laxmikant Kale.

## The problem

Charm++ programs are *over-decomposed*: the work is split into many more tasks (chares) than there are cores, so the runtime can balance load and overlap communication with computation. That is great for compute, but awkward for file input. If every chare reads its own slice of a file, the number of readers is dictated by the application's decomposition rather than by what the file system can handle, and thousands of chares end up contending for both compute and I/O resources. Our naive benchmark showed input performance swinging widely as the chare count changed.

## CkIO

CkIO separates the *input* decomposition from the *application* decomposition. A layer of intermediary **buffer chares** sits between the file system and the application: the number of buffer chares is chosen to match the ideal read parallelism for the file and machine, and they then distribute the data to however many application chares exist over the network. Since the network is fast and I/O is slow, this trade gives consistent input performance regardless of how the application is decomposed.

Because reads are asynchronous, buffer chares hand control back to the Charm++ runtime while waiting on the file system, so unrelated computation can proceed concurrently. In our benchmarks the overlap was nearly perfect: adding background work left the overall runtime roughly unchanged.

## FileReader

Not every application wants to issue large block reads. The talk also introduced `Ck::IO::FileReader`, a buffered abstraction built on the core CkIO API that mimics `std::ifstream` (`read`, `seekg`, `tellg`, `eof`, ...). It is meant for codes that do many small sequential reads and makes porting existing readers straightforward.

## Applying CkIO to ChaNGa

As a case study we integrated FileReader into the Tipsy reader of [ChaNGa](https://github.com/N-BodyShop/changa), a cosmological N-body code. ChaNGa loads its entire input before computation begins, so there is no computation to overlap with, but the separation of concerns still helps. The talk presented preliminary scaling results and discussed future work on automatically choosing the number of buffer chares from the number of processing elements, number of nodes and file size.

Benchmarks were run on Bridges-2 at the Pittsburgh Supercomputing Center, reading a 4 GB file from Lustre across 16 nodes.

The full write-up is in the [CkIO preprint](https://arxiv.org/abs/2411.18593).
