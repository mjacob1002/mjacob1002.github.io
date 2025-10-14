---
layout: page
title: presentations
permalink: /presentations/
description: A collection of presentations, talks, and lectures I have given.
nav: true
nav_order: 6
display_categories: [research, teaching, conferences]
horizontal: false
---

<!-- pages/presentations.md -->
<div class="presentations">
{% if site.enable_presentation_categories and page.display_categories %}
  <!-- Display categorized presentations -->
  {% for category in page.display_categories %}
  <a id="{{ category }}" href=".#{{ category }}">
    <h2 class="category">{{ category }}</h2>
  </a>
  {% assign categorized_presentations = site.presentations | where: "category", category %}
  {% assign sorted_presentations = categorized_presentations | sort: "date" | reverse %}
  <!-- Generate cards for each presentation -->
  {% if page.horizontal %}
  <div class="container">
    <div class="row row-cols-1 row-cols-md-2">
    {% for presentation in sorted_presentations %}
      {% include presentations_horizontal.liquid %}
    {% endfor %}
    </div>
  </div>
  {% else %}
  <div class="row row-cols-1 row-cols-md-3">
    {% for presentation in sorted_presentations %}
      {% include presentations.liquid %}
    {% endfor %}
  </div>
  {% endif %}
  {% endfor %}

{% else %}

<!-- Display presentations without categories -->

{% assign sorted_presentations = site.presentations | sort: "date" | reverse %}

  <!-- Generate cards for each presentation -->

{% if page.horizontal %}

  <div class="container">
    <div class="row row-cols-1 row-cols-md-2">
    {% for presentation in sorted_presentations %}
      {% include presentations_horizontal.liquid %}
    {% endfor %}
    </div>
  </div>
  {% else %}
  <div class="row row-cols-1 row-cols-md-3">
    {% for presentation in sorted_presentations %}
      {% include presentations.liquid %}
    {% endfor %}
  </div>
  {% endif %}
{% endif %}
</div>
