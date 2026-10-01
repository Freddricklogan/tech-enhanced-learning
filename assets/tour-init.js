/** The home page tour: one step per part of the page a new student needs first. */
import { mountTour } from './tour.js';

const STEPS = [
  { selector: '.main-content h1', title: 'The course', body: 'Technology Enhanced Learning & Remote Work: twelve weeks on the tools and habits that make remote study and work effective.' },
  { selector: '.course-card', title: 'What you will do', body: 'The overview says what the course covers and how the weeks are paced.' },
  { selector: '.button-group', title: 'Start here', body: 'The syllabus has the schedule, policies and grading; the modules hold each week\'s material.' },
  { selector: '.featured-sections', title: 'Where things live', body: 'Syllabus, modules and assignments each have their own page, linked from these cards and from the menu.' },
  { selector: '.main-nav', title: 'Find your way back', body: 'The menu is on every page. The assignments page lists each brief with its rubric.' }
];

const button = document.getElementById('exec-tour-start');
// The tour describes the home page; other pages keep the button hidden.
if (button && document.querySelector('.featured-sections')) mountTour(STEPS, button);
