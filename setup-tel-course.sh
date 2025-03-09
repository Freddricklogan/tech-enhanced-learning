#!/bin/bash

# Technology Enhanced Learning Course Setup Script
# This script creates a complete course website and pushes it to GitHub

echo "Setting up Technology Enhanced Learning & Remote Work Course..."
echo "Instructor: Teacher Freddrick"

# Create base directory structure
mkdir -p tech-enhanced-learning/{assets/{css,js,images},_layouts,_includes,_data,modules,assignments,resources,syllabus}
cd tech-enhanced-learning

# Initialize git repository
git init
touch .gitignore README.md _config.yml
echo "*.log\n_site/\n.sass-cache/\n.jekyll-cache/\n.jekyll-metadata\n.DS_Store" > .gitignore

# Create config file
cat > _config.yml << 'EOL'
title: Technology Enhanced Learning & Remote Work
description: Comprehensive course on technology-enhanced learning and remote work environments
baseurl: "/tech-enhanced-learning"
url: "https://USERNAME.github.io"
instructor: "Teacher Freddrick"
email: "freddrick@university.edu"
github_username: "USERNAME"

# Build settings
markdown: kramdown
theme: minima
plugins:
  - jekyll-feed
  - jekyll-seo-tag
EOL

# Create README with GitHub Pages link
cat > README.md << 'EOL'
# Technology Enhanced Learning & Remote Work Course

A comprehensive 12-week course exploring how technology enhances learning and enables remote work opportunities across various industries.

## Live Course Website

[View the Course Website](https://USERNAME.github.io/tech-enhanced-learning/)

## Instructor

Teacher Freddrick (freddrick@university.edu)

## Features

- Interactive syllabus with weekly modules
- Hands-on technical projects and assignments
- Case study development framework
- Remote collaboration simulations
- Comprehensive resources for technology-enhanced learning

## Course Overview

This course balances academic frameworks with hands-on projects, emphasizing both technical proficiency and business applications. Students will engage in collaborative remote work simulations, develop technology integration plans, and create case studies analyzing real-world implementations.

## Repository Structure

- `/syllabus` - Detailed course outline and requirements
- `/modules` - Weekly learning materials and activities
- `/assignments` - Project instructions and templates
- `/resources` - Reading lists and supplementary materials

## License

This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/).
EOL

# Create default layout
mkdir -p _layouts
cat > _layouts/default.html << 'EOL'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{ page.title }} | Technology Enhanced Learning</title>
  <link rel="stylesheet" href="{{ site.baseurl }}/assets/css/main.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
  <header class="site-header">
    <div class="container">
      <a href="{{ site.baseurl }}/" class="site-title">TEL Course</a>
      <nav class="main-nav">
        <a href="{{ site.baseurl }}/" class="nav-link {% if page.url == '/' %}active{% endif %}">Home</a>
        <a href="{{ site.baseurl }}/syllabus/" class="nav-link {% if page.url contains '/syllabus/' %}active{% endif %}">Syllabus</a>
        <a href="{{ site.baseurl }}/modules/" class="nav-link {% if page.url contains '/modules/' %}active{% endif %}">Modules</a>
        <a href="{{ site.baseurl }}/assignments/" class="nav-link {% if page.url contains '/assignments/' %}active{% endif %}">Assignments</a>
        <a href="{{ site.baseurl }}/resources/" class="nav-link {% if page.url contains '/resources/' %}active{% endif %}">Resources</a>
      </nav>
      <button class="menu-toggle" aria-label="Toggle menu">
        <span></span>
        <span></span>
        <span></span>
      </button>
    </div>
  </header>

  <main>
    {{ content }}
  </main>

  <footer class="site-footer">
    <div class="container">
      <div class="footer-content">
        <div class="footer-info">
          <h3>Technology Enhanced Learning</h3>
          <p>A comprehensive course on technology-enhanced learning and remote work environments.</p>
          <p class="instructor">Instructor: Teacher Freddrick</p>
          <p class="contact">Contact: freddrick@university.edu</p>
        </div>
        <div class="footer-links">
          <h3>Quick Links</h3>
          <ul>
            <li><a href="{{ site.baseurl }}/syllabus/">Syllabus</a></li>
            <li><a href="{{ site.baseurl }}/modules/">Modules</a></li>
            <li><a href="{{ site.baseurl }}/assignments/">Assignments</a></li>
            <li><a href="{{ site.baseurl }}/resources/">Resources</a></li>
          </ul>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; 2025 Technology Enhanced Learning Course. All rights reserved.</p>
      </div>
    </div>
  </footer>

  <script>
    document.querySelector('.menu-toggle').addEventListener('click', function() {
      document.querySelector('.main-nav').classList.toggle('active');
      this.classList.toggle('active');
    });
  </script>
</body>
</html>
EOL

# Create CSS file
mkdir -p assets/css
cat > assets/css/main.css << 'EOL'
/* Base styles */
:root {
  --primary-color: #4361ee;
  --secondary-color: #3a0ca3;
  --accent-color: #4cc9f0;
  --dark-color: #1d3557;
  --light-color: #f8f9fa;
  --grey-color: #6c757d;
  --success-color: #2ecc71;
  --warning-color: #f39c12;
  --font-primary: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  --border-radius: 8px;
  --box-shadow: 0 4px 6px rgba(0,0,0,0.1);
  --transition: all 0.3s ease;
}

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: var(--font-primary);
  line-height: 1.6;
  color: var(--dark-color);
  background: var(--light-color);
}

.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

a {
  color: var(--primary-color);
  text-decoration: none;
  transition: var(--transition);
}

a:hover {
  color: var(--secondary-color);
}

h1, h2, h3, h4, h5, h6 {
  margin-bottom: 1rem;
  font-weight: 700;
  line-height: 1.2;
}

h1 {
  font-size: 2.5rem;
  margin-bottom: 1.5rem;
  color: var(--primary-color);
}

h2 {
  font-size: 2rem;
  margin-top: 2rem;
  margin-bottom: 1rem;
}

h3 {
  font-size: 1.5rem;
  margin-top: 1.5rem;
  margin-bottom: 0.75rem;
}

ul, ol {
  margin-bottom: 1rem;
  margin-left: 1.5rem;
}

p {
  margin-bottom: 1rem;
}

/* Header */
.site-header {
  background: white;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  padding: 1rem 0;
  position: sticky;
  top: 0;
  z-index: 1000;
}

.site-header .container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.site-title {
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--primary-color);
}

.main-nav {
  display: flex;
  gap: 1.5rem;
}

.nav-link {
  color: var(--dark-color);
  font-weight: 500;
  padding: 0.5rem;
  border-bottom: 2px solid transparent;
}

.nav-link:hover, .nav-link.active {
  color: var(--primary-color);
  border-bottom-color: var(--primary-color);
}

.menu-toggle {
  display: none;
}

/* Main content */
main {
  min-height: calc(100vh - 140px);
}

/* Hero Section */
.hero {
  padding: 4rem 0;
  background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
  color: white;
  text-align: center;
}

.hero h1 {
  font-size: 3rem;
  color: white;
  margin-bottom: 1rem;
}

.hero-subtitle {
  font-size: 1.5rem;
  opacity: 0.9;
  margin-bottom: 2rem;
}

/* Course Features */
.course-features {
  padding: 4rem 0;
  background: white;
}

.feature-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 2rem;
}

.feature-card {
  background-color: white;
  border-radius: var(--border-radius);
  overflow: hidden;
  box-shadow: var(--box-shadow);
  transition: var(--transition);
}

.feature-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0,0,0,0.12);
}

.feature-icon {
  font-size: 2rem;
  color: var(--primary-color);
  margin-bottom: 1rem;
}

.feature-content {
  padding: 1.5rem;
}

.feature-title {
  font-size: 1.25rem;
  margin-bottom: 0.75rem;
}

/* Button styles */
.button {
  display: inline-block;
  background: var(--primary-color);
  color: white;
  padding: 0.75rem 1.5rem;
  border-radius: var(--border-radius);
  font-weight: 600;
  margin-top: 1rem;
}

.button:hover {
  background: var(--secondary-color);
  color: white;
  transform: translateY(-2px);
}

.button-outline {
  background: transparent;
  border: 2px solid var(--primary-color);
  color: var(--primary-color);
}

.button-outline:hover {
  background: var(--primary-color);
  color: white;
}

/* Cards */
.card {
  background: white;
  border-radius: var(--border-radius);
  overflow: hidden;
  box-shadow: var(--box-shadow);
  margin-bottom: 2rem;
}

.card-header {
  background: var(--primary-color);
  color: white;
  padding: 1.5rem;
}

.card-header h3 {
  margin: 0;
  color: white;
}

.card-body {
  padding: 1.5rem;
}

/* Assignment Cards */
.assignment-cards {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 1.5rem;
  margin-top: 1.5rem;
}

.assignment-card {
  background: white;
  border-radius: var(--border-radius);
  overflow: hidden;
  box-shadow: var(--box-shadow);
  padding: 1.5rem;
  transition: var(--transition);
}

.assignment-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0,0,0,0.12);
}

/* Module Styles */
.module-overview {
  background: white;
  border-radius: var(--border-radius);
  padding: 2rem;
  margin-bottom: 2rem;
  box-shadow: var(--box-shadow);
}

.learning-objectives {
  margin-bottom: 2rem;
}

.topic-section {
  margin-bottom: 2rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #eee;
}

.key-points {
  background: var(--light-color);
  padding: 1rem;
  border-radius: var(--border-radius);
  margin-top: 1rem;
}

/* Footer */
.site-footer {
  background: var(--dark-color);
  color: white;
  padding: 3rem 0 1.5rem;
  margin-top: 4rem;
}

.footer-content {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 2rem;
}

.footer-info h3, .footer-links h3 {
  color: white;
  margin-bottom: 1rem;
}

.instructor, .contact {
  margin-top: 0.5rem;
  opacity: 0.8;
}

.footer-links ul {
  list-style: none;
  margin: 0;
}

.footer-links li {
  margin-bottom: 0.5rem;
}

.footer-links a {
  color: rgba(255, 255, 255, 0.7);
}

.footer-links a:hover {
  color: white;
}

.footer-bottom {
  margin-top: 2rem;
  padding-top: 1.5rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  text-align: center;
  font-size: 0.875rem;
  opacity: 0.7;
}

/* Responsive Styles */
@media (max-width: 768px) {
  .menu-toggle {
    display: block;
    background: none;
    border: none;
    cursor: pointer;
    width: 30px;
    height: 24px;
    position: relative;
  }
  
  .menu-toggle span {
    display: block;
    position: absolute;
    height: 3px;
    width: 100%;
    background: var(--dark-color);
    border-radius: 3px;
    transition: all 0.3s ease;
  }
  
  .menu-toggle span:nth-child(1) {
    top: 0;
  }
  
  .menu-toggle span:nth-child(2) {
    top: 10px;
  }
  
  .menu-toggle span:nth-child(3) {
    top: 20px;
  }
  
  .menu-toggle.active span:nth-child(1) {
    top: 10px;
    transform: rotate(45deg);
  }
  
  .menu-toggle.active span:nth-child(2) {
    opacity: 0;
  }
  
  .menu-toggle.active span:nth-child(3) {
    top: 10px;
    transform: rotate(-45deg);
  }
  
  .main-nav {
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background: white;
    flex-direction: column;
    padding: 1rem;
    box-shadow: 0 5px 10px rgba(0,0,0,0.1);
    display: none;
  }
  
  .main-nav.active {
    display: flex;
  }
  
  .footer-content {
    grid-template-columns: 1fr;
  }
  
  .hero h1 {
    font-size: 2.5rem;
  }
  
  .assignment-cards, .feature-grid {
    grid-template-columns: 1fr;
  }
}
EOL

# Create homepage
cat > index.html << 'EOL'
---
layout: default
title: Technology Enhanced Learning & Remote Work
---
<section class="hero">
  <div class="container">
    <h1>Technology Enhanced Learning & Remote Work</h1>
    <p class="hero-subtitle">Develop the skills needed to excel in technology-driven remote environments</p>
    <a href="syllabus/" class="button">View Syllabus</a>
    <a href="modules/" class="button button-outline">Explore Modules</a>
  </div>
</section>

<section class="course-features">
  <div class="container">
    <h2>Course Features</h2>
    <div class="feature-grid">
      <div class="feature-card">
        <div class="feature-content">
          <div class="feature-icon">
            <i class="fas fa-laptop-code"></i>
          </div>
          <h3 class="feature-title">Technical Projects</h3>
          <p>Develop practical skills through hands-on technical projects relevant to remote work contexts.</p>
          <a href="assignments/" class="button">View Projects</a>
        </div>
      </div>
      
      <div class="feature-card">
        <div class="feature-content">
          <div class="feature-icon">
            <i class="fas fa-users"></i>
          </div>
          <h3 class="feature-title">Collaborative Work</h3>
          <p>Experience simulated remote team projects that mirror real-world work environments.</p>
          <a href="assignments/" class="button">Explore Teams</a>
        </div>
      </div>
      
      <div class="feature-card">
        <div class="feature-content">
          <div class="feature-icon">
            <i class="fas fa-book"></i>
          </div>
          <h3 class="feature-title">Case Studies</h3>
          <p>Analyze and develop case studies examining real-world technology implementations.</p>
          <a href="assignments/case-study/" class="button">View Cases</a>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="course-overview">
  <div class="container">
    <div class="card">
      <div class="card-header">
        <h3>About This Course</h3>
      </div>
      <div class="card-body">
        <p>This 12-week course explores how technology enhances learning and enables remote work opportunities across various industries. Students will develop both the theoretical knowledge and practical skills needed to thrive in distributed work environments.</p>
        
        <h4>Course Instructor</h4>
        <p>Teacher Freddrick brings years of experience in educational technology and remote work management to this course. With a background spanning corporate and academic settings, Teacher Freddrick offers practical insights into the challenges and opportunities of technology-enhanced remote environments.</p>
        
        <h4>Learning Outcomes</h4>
        <ul>
          <li>Analyze how technology transforms learning and work environments</li>
          <li>Apply digital tools effectively for remote collaboration and productivity</li>
          <li>Develop strategies for successful remote work and virtual team management</li>
          <li>Evaluate the effectiveness of technology-enhanced learning approaches</li>
          <li>Create a technology integration plan for a specific learning or work context</li>
        </ul>
        
        <a href="syllabus/" class="button">View Full Syllabus</a>
      </div>
    </div>
  </div>
</section>
EOL

# Create syllabus page
mkdir -p syllabus
cat > syllabus/index.html << 'EOL'
---
layout: default
title: Course Syllabus
---
<div class="container">
  <h1>Course Syllabus</h1>
  
  <div class="card">
    <div class="card-header">
      <h3>Course Information</h3>
    </div>
    <div class="card-body">
      <p><strong>Course:</strong> Technology Enhanced Learning & Remote Work</p>
      <p><strong>Instructor:</strong> Teacher Freddrick</p>
      <p><strong>Email:</strong> freddrick@university.edu</p>
      <p><strong>Office Hours:</strong> Tuesdays 3-5pm (Virtual)</p>
      <p><strong>Duration:</strong> 12 Weeks</p>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Course Description</h3>
    </div>
    <div class="card-body">
      <p>This course explores the intersection of technology, learning, and remote work, preparing students for careers in an increasingly distributed workforce. Students will examine how technology transforms learning environments and enables effective remote work opportunities across various industries. The course balances theoretical frameworks with practical applications, focusing on tools, strategies, and best practices for technology-enhanced learning and remote collaboration. Students will develop both technical proficiency and business acumen necessary for success in remote work environments.</p>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Learning Objectives</h3>
    </div>
    <div class="card-body">
      <p>By the end of this course, students will be able to:</p>
      <ol>
        <li>Analyze the impact of technology on learning environments and work structures</li>
        <li>Apply appropriate digital tools for remote collaboration, productivity, and learning</li>
        <li>Evaluate the effectiveness of various technology-enhanced learning approaches</li>
        <li>Develop strategies for successful remote work and virtual team management</li>
        <li>Design technology integration plans for specific learning or work contexts</li>
        <li>Create and analyze case studies of technology implementation in organizational settings</li>
        <li>Demonstrate proficiency in essential remote work technologies and methodologies</li>
      </ol>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Weekly Schedule</h3>
    </div>
    <div class="card-body">
      <table class="schedule-table">
        <thead>
          <tr>
            <th>Week</th>
            <th>Topic</th>
            <th>Key Assignments</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td>
            <td>Introduction to Technology Enhanced Learning & Remote Work</td>
            <td>Personal Learning Environment Setup</td>
          </tr>
          <tr>
            <td>2</td>
            <td>Digital Tools for Remote Productivity & Collaboration</td>
            <td>Tool Evaluation Exercise</td>
          </tr>
          <tr>
            <td>3</td>
            <td>Learning Theories & Technology Integration</td>
            <td>Virtual Team Challenge</td>
          </tr>
          <tr>
            <td>4</td>
            <td>Virtual Collaboration & Team Management</td>
            <td>Personal Productivity System Project</td>
          </tr>
          <tr>
            <td>5</td>
            <td>Technology for Engagement & Interactivity</td>
            <td>Case Analysis</td>
          </tr>
          <tr>
            <td>6</td>
            <td>Data-Informed Learning & Work</td>
            <td>Analytics Dashboard Exercise</td>
          </tr>
          <tr>
            <td>7</td>
            <td>Project Management in Remote Environments</td>
            <td>Interactive Learning Module</td>
          </tr>
          <tr>
            <td>8</td>
            <td>Building Digital Presence & Professional Portfolio</td>
            <td>Case Research Plan</td>
          </tr>
          <tr>
            <td>9</td>
            <td>Remote Technical Skills & Digital Creation</td>
            <td>Remote Project Simulation</td>
          </tr>
          <tr>
            <td>10</td>
            <td>Case Studies in Technology Implementation</td>
            <td>Implementation Analysis</td>
          </tr>
          <tr>
            <td>11</td>
            <td>Remote Work Policies & Business Considerations</td>
            <td>Remote Work Technology Integration Plan</td>
          </tr>
          <tr>
            <td>12</td>
            <td>Future of Remote Work & Technology</td>
            <td>Final Case Study</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Assessment & Grading</h3>
    </div>
    <div class="card-body">
      <table class="schedule-table">
        <thead>
          <tr>
            <th>Component</th>
            <th>Weight</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Technical Projects</td>
            <td>30%</td>
            <td>Three hands-on projects demonstrating technical skills</td>
          </tr>
          <tr>
            <td>Case Study Development</td>
            <td>25%</td>
            <td>Analysis and creation of a technology implementation case study</td>
          </tr>
          <tr>
            <td>Collaborative Assignments</td>
            <td>20%</td>
            <td>Group work simulating remote team experiences</td>
          </tr>
          <tr>
            <td>Learning Portfolio</td>
            <td>15%</td>
            <td>Documentation of learning journey and application</td>
          </tr>
          <tr>
            <td>Participation</td>
            <td>10%</td>
            <td>Active engagement in discussions and activities</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>
EOL

# Create modules index page
mkdir -p modules
cat > modules/index.html << 'EOL'
---
layout: default
title: Course Modules
---
<div class="container">
  <h1>Course Modules</h1>
  
  <div class="module-overview">
    <p>This course is organized into 12 weekly modules that build essential knowledge and skills for technology-enhanced learning and remote work. Each module combines theoretical frameworks with practical applications.</p>
  </div>
  
  <div class="assignment-cards">
    <div class="assignment-card">
      <h3>Week 1: Introduction to TEL & Remote Work</h3>
      <p>Explore the evolution of technology in learning environments and current trends in remote work.</p>
      <a href="week-1/" class="button">View Module</a>
    </div>
    
    <div class="assignment-card">
      <h3>Week 2: Digital Tools for Remote Productivity</h3>
      <p>Examine tools for productivity, collaboration, and communication in remote environments.</p>
      <a href="#" class="button">View Module</a>
    </div>
    
    <div class="assignment-card">
      <h3>Week 3: Learning Theories & Technology</h3>
      <p>Understand how learning theories inform the design of technology-enhanced experiences.</p>
      <a href="#" class="button">View Module</a>
    </div>
    
    <div class="assignment-card">
      <h3>Week 4: Virtual Collaboration & Teams</h3>
      <p>Learn strategies for effective collaboration and team management in virtual environments.</p>
      <a href="#" class="button">View Module</a>
    </div>
    
    <div class="assignment-card">
      <h3>Week 5: Technology for Engagement</h3>
      <p>Discover tools and approaches for creating engaging remote learning experiences.</p>
      <a href="#" class="button">View Module</a>
    </div>
    
    <div class="assignment-card">
      <h3>Week 6: Data-Informed Learning & Work</h3>
      <p>Explore how data can inform decision-making in learning and work contexts.</p>
      <a href="#" class="button">View Module</a>
    </div>
    
    <div class="assignment-card">
      <h3>Week 7: Project Management for Remote Work</h3>
      <p>Learn methodologies and tools for managing projects in distributed environments.</p>
      <a href="#" class="button">View Module</a>
    </div>
    
    <div class="assignment-card">
      <h3>Week 8: Digital Presence & Portfolios</h3>
      <p>Develop strategies for building a professional digital presence and portfolio.</p>
      <a href="#" class="button">View Module</a>
    </div>
    
    <div class="assignment-card">
      <h3>Week 9: Remote Technical Skills</h3>
      <p>Build essential technical skills for success in remote learning and work environments.</p>
      <a href="#" class="button">View Module</a>
    </div>
    
    <div class="assignment-card">
      <h3>Week 10: Technology Implementation Cases</h3>
      <p>Analyze case studies of successful and unsuccessful technology implementations.</p>
      <a href="#" class="button">View Module</a>
    </div>
    
    <div class="assignment-card">
      <h3>Week 11: Remote Work Policies & Business</h3>
      <p>Examine policies, legal considerations, and business models for remote work.</p>
      <a href="#" class="button">View Module</a>
    </div>
    
    <div class="assignment-card">
      <h3>Week 12: Future of Remote Work & Technology</h3>
      <p>Explore emerging technologies and future trends in remote work and learning.</p>
      <a href="#" class="button">View Module</a>
    </div>
  </div>
</div>
EOL

# Create sample week 1 module
mkdir -p modules/week-1
cat > modules/week-1/index.html << 'EOL'
---
layout: default
title: Week 1 - Introduction to Technology Enhanced Learning & Remote Work
---
<div class="container">
  <h1>Week 1: Introduction to Technology Enhanced Learning & Remote Work</h1>
  
  <div class="module-overview">
    <p>This introductory module establishes the foundation for understanding how technology transforms learning and work environments. We'll explore current trends in remote work, examine the evolution of technology-enhanced learning, and prepare our personal learning environment for the course.</p>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Learning Objectives</h3>
    </div>
    <div class="card-body">
      <ul>
        <li>Analyze the evolution of technology in learning environments</li>
        <li>Evaluate current trends and statistics in remote work</li>
        <li>Identify benefits and challenges of technology-enhanced learning</li>
        <li>Set up a personal learning environment for remote learning</li>
      </ul>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Key Topics</h3>
    </div>
    <div class="card-body">
      <div class="topic-section">
        <h4>Evolution of Technology in Learning</h4>
        <p>Technology has transformed learning from traditional classroom settings to dynamic, flexible environments that adapt to individual needs. This section traces the key developments in educational technology from early computer-based training to modern AI-driven adaptive learning systems.</p>
        
        <div class="key-points">
          <h5>Key Points:</h5>
          <ul>
            <li>From CBT to LMS: The evolution of learning platforms</li>
            <li>Web 2.0 and social learning technologies</li>
            <li>Mobile learning and app-based education</li>
            <li>AI and adaptive learning systems</li>
          </ul>
        </div>
      </div>
      
      <div class="topic-section">
        <h4>Remote Work Landscape</h4>
        <p>The global shift toward remote work has accelerated dramatically in recent years. This section examines current statistics, trends, and projections for remote work across different industries and roles.</p>
        
        <div class="key-points">
          <h5>Key Points:</h5>
          <ul>
            <li>Global remote work adoption by industry</li>
            <li>Technology roles and remote work compatibility</li>
            <li>Hybrid work models and implementation approaches</li>
            <li>Geographic and demographic trends in remote work</li>
          </ul>
        </div>
      </div>
      
      <div class="topic-section">
        <h4>Personal Learning Environments</h4>
        <p>Effective remote learning and work require thoughtful setup of personal learning environments. This section covers strategies for creating productive digital workspaces that support learning and professional activities.</p>
        
        <div class="key-points">
          <h5>Key Points:</h5>
          <ul>
            <li>Digital tools for personal learning environments</li>
            <li>Physical workspace considerations</li>
            <li>Productivity and focus strategies</li>
            <li>Personal knowledge management approaches</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Activities & Assignments</h3>
    </div>
    <div class="card-body">
      <div class="activity-item">
        <h4>Personal Learning Environment Setup</h4>
        <p>Establish your personal learning environment (PLE) for this course, integrating tools for note-taking, task management, and information organization.</p>
        <a href="../../assignments/ple-setup/" class="button">View Assignment</a>
      </div>
      
      <div class="activity-item">
        <h4>Remote Work Reflection</h4>
        <p>Reflect on your experiences with remote learning or work, identifying challenges, successes, and strategies for improvement.</p>
        <a href="../../assignments/remote-reflection/" class="button">View Assignment</a>
      </div>
      
      <div class="activity-item">
        <h4>Discussion: Technology Evolution</h4>
        <p>Participate in a discussion about how technology has changed learning and work environments in your field or industry.</p>
      </div>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Resources</h3>
    </div>
    <div class="card-body">
      <div class="resource-section">
        <h4>Essential Readings</h4>
        <ul>
          <li>Siemens, G., & Tittenberger, P. (2024). <em>Handbook of emerging technologies for learning</em>. University of Manitoba. (Chapter 1)</li>
          <li>Wang, T., & Park, C. (2023). <em>Remote work revolution: Succeeding from anywhere</em>. Harvard Business Review Press. (Introduction)</li>
          <li>Hodges, C., et al. (2023). <em>The difference between emergency remote teaching and quality online learning</em>. EDUCAUSE Review.</li>
        </ul>
      </div>
      
      <div class="resource-section">
        <h4>Supplementary Materials</h4>
        <ul>
          <li><a href="https://www.mckinsey.com/featured-insights/future-of-work" target="_blank">McKinsey: The future of work after COVID-19</a></li>
          <li><a href="https://globalworkplaceanalytics.com/" target="_blank">Global Workplace Analytics: Remote Work Statistics</a></li>
          <li><a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ" target="_blank">Video: Setting Up Your Remote Workspace for Success</a></li>
        </ul>
      </div>
    </div>
  </div>
</div>
EOL

# Create assignments index
mkdir -p assignments
cat > assignments/index.html << 'EOL'
---
layout: default
title: Course Assignments
---
<div class="container">
  <h1>Course Assignments</h1>
  
  <div class="module-overview">
    <p>The assignments in this course are designed to develop practical skills for technology-enhanced learning and remote work. They include technical projects, case study development, and collaborative activities that simulate real-world remote work scenarios.</p>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Technical Projects (30%)</h3>
    </div>
    <div class="card-body">
      <p>These hands-on projects develop practical skills essential for remote work environments.</p>
      
      <div class="assignment-cards">
        <div class="assignment-card">
          <h4>Personal Productivity System</h4>
          <p><strong>Due:</strong> Week 4</p>
          <p>Design and implement a personal productivity system using digital tools for task management, note-taking, and time tracking.</p>
          <a href="personal-productivity/" class="button">View Details</a>
        </div>
        
        <div class="assignment-card">
          <h4>Interactive Learning Module</h4>
          <p><strong>Due:</strong> Week 7</p>
          <p>Create a small interactive learning module using authoring tools to demonstrate effective application of multimedia learning principles.</p>
          <a href="#" class="button">View Details</a>
        </div>
        
        <div class="assignment-card">
          <h4>Remote Work Technology Integration Plan</h4>
          <p><strong>Due:</strong> Week 11</p>
          <p>Develop a comprehensive technology integration plan for a remote team or learning environment.</p>
          <a href="#" class="button">View Details</a>
        </div>
      </div>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Case Study Development (25%)</h3>
    </div>
    <div class="card-body">
      <p>Research, analyze, and create a case study examining a real-world implementation of technology in a learning or work context.</p>
      
      <div class="assignment-cards">
        <div class="assignment-card">
          <h4>Case Analysis</h4>
          <p><strong>Due:</strong> Week 5</p>
          <p>Analysis of an existing case study, identifying key factors in success or failure.</p>
          <a href="#" class="button">View Details</a>
        </div>
        
        <div class="assignment-card">
          <h4>Case Research Plan</h4>
          <p><strong>Due:</strong> Week 8</p>
          <p>Development of a plan for original case study research.</p>
          <a href="#" class="button">View Details</a>
        </div>
        
        <div class="assignment-card">
          <h4>Final Case Study</h4>
          <p><strong>Due:</strong> Week 12</p>
          <p>Creation of an original case study based on research and analysis.</p>
          <a href="#" class="button">View Details</a>
        </div>
      </div>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Collaborative Assignments (20%)</h3>
    </div>
    <div class="card-body">
      <p>Group work assignments simulating remote team experiences.</p>
      
      <div class="assignment-cards">
        <div class="assignment-card">
          <h4>Virtual Team Challenge</h4>
          <p><strong>Due:</strong> Week 3</p>
          <p>Collaborative problem-solving exercise using remote collaboration tools.</p>
          <a href="#" class="button">View Details</a>
        </div>
        
        <div class="assignment-card">
          <h4>Remote Project Simulation</h4>
          <p><strong>Due:</strong> Week 9</p>
          <p>Team-based project with defined roles and deliverables.</p>
          <a href="#" class="button">View Details</a>
        </div>
      </div>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Learning Portfolio (15%)</h3>
    </div>
    <div class="card-body">
      <p>Documentation of your learning journey including:</p>
      <ul>
        <li>Weekly reflections on personal insights and applications</li>
        <li>Curated collection of resources and tools</li>
        <li>Evidence of skill development</li>
        <li>Final reflection on learning outcomes and future applications</li>
      </ul>
      <p><strong>Due:</strong> Incremental submissions throughout the course with final portfolio due Week 12</p>
      <a href="#" class="button">View Details</a>
    </div>
  </div>
</div>
EOL

# Create personal productivity assignment
mkdir -p assignments/personal-productivity
cat > assignments/personal-productivity/index.html << 'EOL'
---
layout: default
title: Personal Productivity System Assignment
---
<div class="container">
  <h1>Technical Project: Personal Productivity System</h1>
  
  <div class="module-overview">
    <p>In this assignment, you will design and implement a personal productivity system that leverages digital tools to enhance your efficiency in a remote work environment. You'll select and integrate tools for task management, note-taking, time tracking, and file organization.</p>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Learning Objectives</h3>
    </div>
    <div class="card-body">
      <ul>
        <li>Evaluate digital productivity tools for remote work contexts</li>
        <li>Implement a personalized system for remote work efficiency</li>
        <li>Apply best practices for digital organization and productivity</li>
        <li>Analyze the effectiveness of your productivity system</li>
      </ul>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Requirements</h3>
    </div>
    <div class="card-body">
      <div class="requirement-section">
        <h4>1. Digital Tool Selection & Integration</h4>
        <ul>
          <li>Select at least 3 interconnected digital tools covering:
            <ul>
              <li>Task/project management</li>
              <li>Note-taking and knowledge management</li>
              <li>Time tracking and analysis</li>
              <li>Cloud storage and file organization</li>
            </ul>
          </li>
          <li>Demonstrate how these tools integrate with each other</li>
        </ul>
      </div>
      
      <div class="requirement-section">
        <h4>2. System Implementation</h4>
        <ul>
          <li>Configure each tool with appropriate settings</li>
          <li>Create a workflow diagram showing information flow between tools</li>
          <li>Implement structure, tags, categories, or other organizational systems</li>
          <li>Document your implementation with screenshots and explanations</li>
        </ul>
      </div>
      
      <div class="requirement-section">
        <h4>3. Practical Application</h4>
        <ul>
          <li>Use your system for at least one week</li>
          <li>Track a minimum of one personal project and one academic/professional project</li>
          <li>Collect data on your productivity and tool effectiveness</li>
        </ul>
      </div>
      
      <div class="requirement-section">
        <h4>4. Analysis & Reflection</h4>
        <ul>
          <li>Analyze strengths and weaknesses of your system</li>
          <li>Identify improvements or adjustments based on your experience</li>
          <li>Reflect on how this system would scale to team use</li>
          <li>Discuss how this system aligns with remote work best practices</li>
        </ul>
      </div>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Deliverables</h3>
    </div>
    <div class="card-body">
      <ol>
        <li><strong>Implementation Report (PDF, 5-7 pages):</strong>
          <ul>
            <li>Introduction and goals for your productivity system</li>
            <li>Tool selection justification</li>
            <li>Implementation details with screenshots</li>
            <li>Analysis of effectiveness</li>
            <li>Recommendations for improvements</li>
          </ul>
        </li>
        <li><strong>System Demonstration (5-7 minute video):</strong>
          <ul>
            <li>Walkthrough of your productivity system</li>
            <li>Demonstration of workflow across tools</li>
            <li>Example of tracking a typical project/task</li>
          </ul>
        </li>
      </ol>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Evaluation Criteria</h3>
    </div>
    <div class="card-body">
      <ul>
        <li>Tool selection appropriateness (20%)</li>
        <li>Implementation quality and integration (30%)</li>
        <li>Practical application and testing (20%)</li>
        <li>Analysis depth and insights (20%)</li>
        <li>Communication clarity and presentation (10%)</li>
      </ul>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Instructor Notes</h3>
    </div>
    <div class="card-body">
      <p>Teacher Freddrick's Tips:</p>
      <ul>
        <li>Focus on creating a system that works for <em>you</em> rather than trying to implement someone else's ideal system.</li>
        <li>Consider both your current workflow and how you'd like to improve it when selecting tools.</li>
        <li>Remember that the goal is sustainable productivity, not perfect organization.</li>
        <li>I recommend starting with simple tools and adding complexity only as needed.</li>
        <li>Documentation is key - keep track of what works and what doesn't as you implement your system.</li>
      </ul>
    </div>
  </div>
</div>
EOL

# Create resources index
mkdir -p resources
cat > resources/index.html << 'EOL'
---
layout: default
title: Course Resources
---
<div class="container">
  <h1>Course Resources</h1>
  
  <div class="module-overview">
    <p>This page provides access to essential resources for the Technology Enhanced Learning & Remote Work course, including reading lists, tool recommendations, and external links.</p>
  </div>
  
  <div class="assignment-cards">
    <div class="assignment-card">
      <div class="feature-icon">
        <i class="fas fa-book"></i>
      </div>
      <h3>Reading List</h3>
      <p>Essential and supplementary readings for each module of the course.</p>
      <a href="reading-list/" class="button">View Readings</a>
    </div>
    
    <div class="assignment-card">
      <div class="feature-icon">
        <i class="fas fa-tools"></i>
      </div>
      <h3>Tools & Software</h3>
      <p>Recommended digital tools for remote learning, collaboration, and productivity.</p>
      <a href="tools/" class="button">View Tools</a>
    </div>
    
    <div class="assignment-card">
      <div class="feature-icon">
        <i class="fas fa-external-link-alt"></i>
      </div>
      <h3>External Resources</h3>
      <p>Additional resources including websites, online communities, and learning platforms.</p>
      <a href="external-links/" class="button">View Links</a>
    </div>
    
    <div class="assignment-card">
      <div class="feature-icon">
        <i class="fas fa-file-alt"></i>
      </div>
      <h3>Templates</h3>
      <p>Templates for assignments, projects, and other course activities.</p>
      <a href="templates/" class="button">View Templates</a>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Course Policies</h3>
    </div>
    <div class="card-body">
      <div class="requirement-section">
        <h4>Communication Policy</h4>
        <ul>
          <li>Teacher Freddrick will respond to emails within 24 hours (48 hours on weekends)</li>
          <li>Weekly announcements will be posted every Monday</li>
          <li>Students should check course platform at least 3 times per week</li>
          <li>Technical issues should be reported immediately</li>
        </ul>
      </div>
      
      <div class="requirement-section">
        <h4>Late Work Policy</h4>
        <ul>
          <li>Assignments submitted within 24 hours after deadline: 10% penalty</li>
          <li>Assignments submitted within 48 hours after deadline: 20% penalty</li>
          <li>Assignments more than 48 hours late require instructor approval</li>
        </ul>
      </div>
      
      <div class="requirement-section">
        <h4>Technology Support</h4>
        <ul>
          <li>Technical support resources will be provided through the university</li>
          <li>Basic troubleshooting guides available in course resources</li>
          <li>Peer technology help forum available for student collaboration</li>
        </ul>
      </div>
    </div>
  </div>
</div>
EOL

# Create reading list page
mkdir -p resources/reading-list
cat > resources/reading-list/index.html << 'EOL'
---
layout: default
title: Course Reading List
---
<div class="container">
  <h1>Course Reading List</h1>
  
  <div class="module-overview">
    <p>The following reading list provides essential and recommended resources for each module of the Technology Enhanced Learning & Remote Work course. All required readings will be made available through the course platform.</p>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Week 1: Introduction to Technology Enhanced Learning & Remote Work</h3>
    </div>
    <div class="card-body">
      <div class="resource-section">
        <h4>Essential Readings</h4>
        <ul>
          <li>Siemens, G., & Tittenberger, P. (2024). <em>Handbook of emerging technologies for learning</em>. University of Manitoba. (Chapter 1)</li>
          <li>Wang, T., & Park, C. (2023). <em>Remote work revolution: Succeeding from anywhere</em>. Harvard Business Review Press. (Introduction)</li>
        </ul>
      </div>
      
      <div class="resource-section">
        <h4>Recommended Resources</h4>
        <ul>
          <li>Global Workplace Analytics. (2024). <em>State of remote work</em>.</li>
          <li>McKinsey & Company. (2023). <em>The future of work after COVID-19</em>.</li>
        </ul>
      </div>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <h3>Week 2: Digital Tools for Remote Productivity & Collaboration</h3>
    </div>
    <div class="card-body">
      <div class="resource-section">
        <h4>Essential Readings</h4>
        <ul>
          <li>Fried, J., & Heinemeier Hansson, D. (2023). <em>Remote: Office not required</em>. Crown Business. (Chapters 1-3)</li>
          <li>Sutherland, K., & Jarratt, D. (2024). <em>Work together anywhere: A handbook on working remotely</em>. Wiley. (Chapter 2)</li>
        </ul>
      </div>
      
      <div class="resource-section">
        <h4>Recommended Resources</h4>
        <ul>
          <li>Reynolds, G. (2023). <em>Presentation Zen: Simple ideas on presentation design and delivery</em>. New Riders.</li>
          <li>Warschauer, M., & Matuchniak, T. (2023). <em>New technology and digital worlds: Analyzing evidence of equity in access, use, and outcomes</em>. Review of Research in Education.</li>
        </ul>
      </div>
    </div>
  </div>
  
  <!-- Additional weeks would follow the same pattern -->
  
  <div class="card">
    <div class="card-header">
      <h3>Note from Teacher Freddrick</h3>
    </div>
    <div class="card-body">
      <p>The reading list will be updated throughout the semester with current articles and resources. Additional readings specific to your interests or project topics can be recommended upon request.</p>
      <p>While all essential readings will be provided through the course platform, I encourage you to explore the recommended resources for deeper understanding of course topics.</p>
    </div>
  </div>
</div>
EOL

# Push to GitHub
echo "Setting up Git repository and pushing to GitHub..."

# Replace USERNAME placeholder with your actual GitHub username
# This must be done manually after the script runs

# Commit all files
git add .
git commit -m "Initial setup of Technology Enhanced Learning course website"

echo "Setup complete! Next steps:"
echo "1. Create a new repository on GitHub named 'tech-enhanced-learning'"
echo "2. Run the following commands to push your local repository to GitHub:"
echo "   git remote add origin https://github.com/YOUR_USERNAME/tech-enhanced-learning.git"
echo "   git push -u origin main"
echo "3. Enable GitHub Pages in your repository settings"
echo "4. Your site will be available at https://YOUR_USERNAME.github.io/tech-enhanced-learning/"
echo ""
echo "Course created by Teacher Freddrick"