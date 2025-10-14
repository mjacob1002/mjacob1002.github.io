# Presentations Section

This section allows you to showcase presentations, talks, and lectures you have given. It's organized similarly to the projects section but tailored for academic and professional presentations.

## How to Add a New Presentation

1. Create a new markdown file in the `_presentations/` directory
2. Use the following front matter structure:

```yaml
---
layout: distill
title: "Your Presentation Title"
description: "Brief description of the presentation"
category: research  # Options: research, teaching, conferences
date: 2024-12-01
venue: "Where you gave the presentation"
img: /assets/img/path/to/image.jpg  # Optional: thumbnail image
slides: https://slides.com/your-slides  # Optional: link to slides
video: https://youtube.com/watch?v=example  # Optional: video recording
pdf: /assets/pdf/path/to/presentation.pdf  # Optional: PDF version
redirect: https://external-link.com  # Optional: external link
importance: 1  # Higher numbers = more important
---
```

## Available Categories

- **research**: Research presentations, seminars, and academic talks
- **teaching**: Lectures, tutorials, and educational presentations
- **conferences**: Conference presentations, workshops, and symposiums

## Features

- **Categorized Display**: Presentations are automatically organized by category
- **Multiple Formats**: Support for slides, video recordings, and PDF versions
- **Responsive Design**: Works on both desktop and mobile devices
- **Horizontal Layout**: Option to display presentations in a horizontal card layout
- **Automatic Sorting**: Presentations are sorted by date (newest first)

## Configuration

The presentations section is configured in `_config.yml`:

```yaml
enable_presentation_categories: true
collections:
  presentations:
    output: true
    permalink: /:collection/:title/
```

## Navigation

The presentations page is automatically added to the navigation with `nav_order: 6`. You can adjust this number to change the order in the navigation menu.

## Styling

Custom CSS styles are defined in `_sass/_base.scss` under the `.presentations` class. The section uses the same styling patterns as the projects section for consistency.

## Icons

The section uses Tabler Icons for the presentation-related icons:
- `ti-presentation` for slides
- `ti-video` for video recordings  
- `ti-file-text` for PDF versions

## Example Presentations

Check the `_presentations/` directory for example presentation files that demonstrate the various features and options available.
