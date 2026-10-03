---
layout: distill
title: "Drowning in Documents: Consequences of Scaling Reranker Inference"
description: "Mathew Jacob, Erik Lindgren, Matei Zaharia, Michael Carbin, Omar Khattab, Andrew Drozdov. Workshop talk at ReNeuIR @ SIGIR 2025, presented by Andrew Drozdov."
category: research
date: 2025-07-18
venue: "ReNeuIR Workshop @ SIGIR 2025, Padova, Italy"
img: /assets/img/publication_preview/reranker_drowning_in_documents.jpeg
slides: https://docs.google.com/presentation/d/1gmm3hAvzPftHR75_5fYpfxIo_6vZe1DNxlmji2PFqM4/edit
pdf: /assets/pdf/papers/drowning_in_documents.pdf
importance: 1
---

Our talk at the [Workshop on Reaching Efficiency in Neural Information Retrieval (ReNeuIR)](https://reneuir.org/) at SIGIR 2025 in Padova, on work from my internship at Databricks Mosaic Research.

## The question

A standard RAG pipeline retrieves candidate documents with a cheap first-stage retriever and then re-scores them with a more expensive cross-encoder reranker. The reranker is assumed to be the more accurate model, so the natural instinct is to hand it as many documents as you can afford: retrieve more, rerank more, get a better answer. The talk opens with a running example (what to eat in Padova) and asks the obvious follow-up question: how many documents *should* we retrieve for the reranker?

## What we measured

Rather than only re-scoring a small top-k, we measured reranker quality as the number of reranked documents grows all the way to full retrieval. We covered sparse (BM25) and enterprise dense retrievers (text-embedding-3-large, voyage-2), open-source and enterprise cross-encoders (bge-reranker-v2-m3, Cohere, Voyage), and a listwise LLM reranker, across academic benchmarks (BRIGHT, BIRCO, BEIR/SciFact) and enterprise datasets (FinanceBench, ManufactQA, DocsQA).

## What we found

Rerankers give diminishing returns as they score more documents, and past a certain point quality actually gets *worse*: the reranker can end up below the first-stage retriever it was supposed to improve on. Looking at failures, rerankers frequently assign high scores to documents with no lexical or semantic overlap with the query at all. The talk introduces a small taxonomy for how a retriever/reranker pair behaves as k grows (helps, never hurts, distracted, scaling is best, scaling hurts) and suggests an evaluation protocol that sweeps k rather than reporting a single top-k number.

The talk closes by connecting this to prior work on stochastic retrieval-conditioned reranking and on inference scaling "flaws", and with where we see hope: listwise LLM rerankers, which held up noticeably better in our experiments.

The paper is on [arXiv](https://arxiv.org/abs/2411.11767), and the work was later discussed on the [Weaviate Podcast](https://www.youtube.com/watch?v=fWuavBcoTzk).
