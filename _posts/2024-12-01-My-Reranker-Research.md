---
layout: post
title: Some Thoughts on Research
date: 2024-12-01 11:12:00-0400
description: Some backstory and extra thoughts about my reranker research
tags: ML, Databricks, Research, RAG
categories: sample-posts external-services
---

It's been about a week and a half since my preprint from Databricks Mosaic Research went live. If you want to see it, check out the [arxiv link](https://arxiv.org/abs/2411.11767) or the Twitter thread I posted.
In this post, I wanted to detail the chronological story of how this work came to be, as well as some thoughts from someone who, before this, had done no ML research at all.
{% twitter https://x.com/mat_jacob1002/status/1859296250731888957 %}

# The Story
At the beginning of my internship in May 2024, I was tasked with better understanding the latency-quality tradeoffs of different rerankers. Mind you, I hadn't done any machine learning at this point. I had only just taken a machine learning course during my Spring 2024 semester, so I was a little nervous, to say the least.

I had read various papers at this point, so I had a general idea of what the general architecture of RAG and IR pipelines were, and how the different components interacted. Namely, in most architectures, you usually have 2-stage pipelines: a first-stage retriever(usually based on embedding models) that search the entire corpus quickly for candidate documents, and then a second-stage "reranker" that reorders the documents given by the retriever. From what I understood in my readings, rerankers were supposed to be more accurate models than retrievers, but were just very computationally expensive and couldn't feasibly be score the entire corpus in a reasonable amount of time. Hence, you have this _cascading_ architecture, where the quick retriever gives you a smaller pool of candidates, so the reranker can feasibly rerank them. This was "common knowledge", as every blog post and paper implied the same thing.

When I first started the experiments, I saw significant improvements in total recall when retrieving a few hundred documents for the reranker to score. To further sketch out this cost-quality Pareto curve, I decided to retrieve more documents. However, I saw the quality dip drastically. Initially, I was positive I had a mistake in my code somewhere. After all, the prevailing notion was that rerankers are superior ranking models than embedding models. Not only that, we were using established rerankers that are from reputable researchers. Assuming that the community's assumption were correct, the rerankers should not be decreasing the recall significantly. This was the beginning of our deep dive into reranker quality detailed in our paper. What I thought was clearly a mistake from someone with little experience (me) turned out to be a paper that has gotten great reception by the community and top researchers, which I'm grateful for.

# Relfections

With a little bit of context given, this section will just a few thoughts reflecting on this amazing internship experience, adapting to research in a field that was foreign to me, and research more broadly.

## Immersion
Firstly, one thing I quickly realized is that in order to adapt and understand a brand new field, especially one that was compeletely different from my systems and HPC background, it is crucial to immerse yourself in the field. For me, the immediately obvious thing for me is
read papers. A lot of them. The first papers you read will be tough, as even with some foundational knowledge, they might be dense with concepts foreign to you. But over time, after a lot of googling and YouTube videos initially, the papers become easier.

For me, I started with reading some of the important reranking and RAG papers. This included things like the [original ColBERT paper](https://arxiv.org/abs/2004.12832), [RankZephyr](https://arxiv.org/abs/2312.02724), and others. Those first reads were dense, to say the least. Even with the diagrams and clear descriptions, I had to do so much extra Googling just to understand what was happening, as I was unfamiliar with ideas like embeddings, reranking, and even the metrics like NDCG and Recall. After all, my domain was about interconnects, supercomputers, parallel programming paradigms, and systems optimization! But by reading a lot of papers initially and trying my best to understand them, I got familiar with the field where I at least knew the intuition and basic concepts. 

Another thing to immerse yourself in the field is to interact with experts in that field and talk with them. For me, that was easy. I had amazing mentors to talk to who helped me better understand the concepts and also aided in building my intuition. But beyond that, when I joined twitter. There, I found regular access to commentary on the field generally, as well as the latest papers and interesting ideas. 

## Write Down Everything

This is advice I got during the internship, when I was perplexed by some of the results I was getting. As long as you write it down,
it's science. And in the end, they were definitely right!

Beyond results, it was also extremely helpful to write down the experiments I planned to run. Doing so not only helped me formalize how
I wanted to structure the experiment, but also helped me consider what the outcomes would be with a positive or negative result.
Thus, it helped me create experiments where, no matter whether the result was positive or negative, it moved the project forward
in some meaningful way.

