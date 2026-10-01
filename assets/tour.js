/**
 * Guided tour for the course site: the same tour engine and card placement as the portfolio's
 * Executive Shell, vendored without the rest of the shell. Placement lives in tour-place.js
 * (pure, tested); this file is the DOM side.
 */
import { centreTourCard, placeTourCard } from './tour-place.js';

function el(tag, props = {}, kids = []) {
  const node = document.createElement(tag);
  for (const [key, value] of Object.entries(props)) {
    if (value === undefined || value === null || value === false) continue;
    if (key === 'class') node.className = value;
    else if (key === 'text') node.textContent = value;
    else if (key === 'html') node.innerHTML = value;
    else if (key === 'dataset') Object.assign(node.dataset, value);
    else node.setAttribute(key, value === true ? '' : String(value));
  }
  for (const kid of kids) {
    if (kid == null) continue;
    node.append(kid);
  }
  return node;
}

function prefersReducedMotion() {
  return (
    typeof matchMedia === 'function' &&
    matchMedia('(prefers-reduced-motion: reduce)').matches
  );
}

function buildTour(steps, tourBtn) {
  if (!steps.length) {
    return { start() {}, stop() {}, destroy() {} };
  }

  let index = 0;
  let open = false;
  let lastFocus = null;

  const spot = el('div', { class: 'exec-tour-spot' });
  const stepEl = el('div', { class: 'exec-tour-card__step' });
  const titleEl = el('h2', { class: 'exec-tour-card__title', id: 'exec-tour-title' });
  const bodyEl = el('p', { class: 'exec-tour-card__body' });

  const prevBtn = el('button', { type: 'button', class: 'exec-btn' }, ['Back']);
  const nextBtn = el('button', { type: 'button', class: 'exec-btn exec-btn--primary' }, ['Next']);
  const closeBtn = el('button', { type: 'button', class: 'exec-btn' }, ['Close']);

  const card = el(
    'div',
    {
      class: 'exec-tour-card',
      role: 'dialog',
      'aria-modal': 'true',
      'aria-labelledby': 'exec-tour-title'
    },
    [
      stepEl,
      titleEl,
      bodyEl,
      el('div', { class: 'exec-tour-card__nav' }, [
        closeBtn,
        el('span', { class: 'exec-tour-card__spacer' }),
        prevBtn,
        nextBtn
      ]),
      el('p', {
        class: 'exec-tour-card__hint',
        html:
          '<kbd>&larr;</kbd> <kbd>&rarr;</kbd> to step · <kbd>Esc</kbd> to close'
      })
    ]
  );

  const backdrop = el('div', { class: 'exec-tour-backdrop', hidden: true }, [spot, card]);
  document.body.append(backdrop);

  async function render() {
    const step = steps[index];
    stepEl.textContent = `Step ${index + 1} of ${steps.length}`;
    titleEl.textContent = step.title;
    bodyEl.textContent = step.body;
    prevBtn.disabled = index === 0;
    nextBtn.textContent = index === steps.length - 1 ? 'Finish' : 'Next';

    if (typeof step.action === 'function') {
      try {
        await step.action();
      } catch (err) {
        // A failed demo action must never break the tour chrome.
        bodyEl.textContent = `${step.body} (step action unavailable)`;
        if (typeof console !== 'undefined' && console.warn) {
          console.warn('Tour step action failed:', err);
        }
      }
    }
    await position(step);
  }

  /** Resolve once scrolling has stopped (two equal readings 50 ms apart, at most 900 ms). */
  function scrollSettled() {
    return new Promise((resolve) => {
      let last = -1;
      let waited = 0;
      const tick = () => {
        const y = window.scrollY;
        if (y === last || waited >= 900) return resolve();
        last = y;
        waited += 50;
        setTimeout(tick, 50);
      };
      setTimeout(tick, 50);
    });
  }

  async function position(step) {
    const target = step.selector ? document.querySelector(step.selector) : null;
    const vw = window.innerWidth;
    const vh = window.innerHeight;

    if (!target) {
      spot.style.display = 'none';
      const c = centreTourCard({ vw, vh, cw: card.offsetWidth, ch: card.offsetHeight });
      card.style.left = `${c.left}px`;
      card.style.top = `${c.top}px`;
      return;
    }

    target.scrollIntoView({
      block: 'center',
      behavior: prefersReducedMotion() ? 'auto' : 'smooth'
    });
    await scrollSettled();

    const r = target.getBoundingClientRect();
    spot.style.display = '';
    spot.style.left = `${Math.max(4, r.left - 6)}px`;
    spot.style.top = `${Math.max(4, r.top - 6)}px`;
    spot.style.width = `${r.width + 12}px`;
    spot.style.height = `${r.height + 12}px`;

    const { left, top } = placeTourCard({
      rect: r,
      vw,
      vh,
      cw: card.offsetWidth || 360,
      ch: card.offsetHeight || 220
    });
    card.style.left = `${left}px`;
    card.style.top = `${top}px`;
  }

  function onKeydown(event) {
    if (!open) return;
    if (event.key === 'Escape') {
      event.preventDefault();
      stop();
    } else if (event.key === 'ArrowRight') {
      event.preventDefault();
      next();
    } else if (event.key === 'ArrowLeft') {
      event.preventDefault();
      prev();
    } else if (event.key === 'Tab') {
      trapFocus(event);
    }
  }

  function trapFocus(event) {
    const nodes = [...card.querySelectorAll(FOCUSABLE)].filter((n) => !n.disabled);
    if (!nodes.length) return;
    const first = nodes[0];
    const last = nodes[nodes.length - 1];
    if (event.shiftKey && document.activeElement === first) {
      event.preventDefault();
      last.focus();
    } else if (!event.shiftKey && document.activeElement === last) {
      event.preventDefault();
      first.focus();
    }
  }

  function onResize() {
    if (open) position(steps[index]);
  }

  function next() {
    if (index === steps.length - 1) {
      stop();
      return;
    }
    index += 1;
    void render();
  }

  function prev() {
    if (index === 0) return;
    index -= 1;
    void render();
  }

  function start() {
    if (open) return;
    open = true;
    index = 0;
    lastFocus = document.activeElement;
    backdrop.hidden = false;
    void render().then(() => nextBtn.focus());
  }

  function stop() {
    if (!open) return;
    open = false;
    backdrop.hidden = true;
    if (lastFocus && typeof lastFocus.focus === 'function') lastFocus.focus();
  }

  tourBtn.addEventListener('click', start);
  nextBtn.addEventListener('click', next);
  prevBtn.addEventListener('click', prev);
  closeBtn.addEventListener('click', stop);
  backdrop.addEventListener('click', (event) => {
    if (event.target === backdrop) stop();
  });
  document.addEventListener('keydown', onKeydown);
  window.addEventListener('resize', onResize);

  return {
    start,
    stop,
    destroy() {
      document.removeEventListener('keydown', onKeydown);
      window.removeEventListener('resize', onResize);
      backdrop.remove();
    }
  };
}

/**
 * Mount a tour on a button. Steps whose target is missing on this page are dropped; with no
 * steps left the button stays hidden.
 * @param {{ selector?: string, title: string, body: string }[]} steps
 * @param {HTMLElement} button
 */
export function mountTour(steps, button) {
  const usable = steps.filter((s) => !s.selector || document.querySelector(s.selector));
  if (!usable.length) return null;
  button.hidden = false;
  return buildTour(usable, button);
}
