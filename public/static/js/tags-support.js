// do something
const tagsMap = new Map();
const headingsMap = new Map();
document.querySelectorAll('[data-tags]').forEach((el) => {

  let tags = el.dataset.tags.trim().split(' ');
  if ( tags.length == 1 && tags[0] == '' ) { return; }
  tags.forEach((tag) => {
    tagsMap.set(tag, (tagsMap.get(tag) || 0) + 1);
  })
});

// const sortedTagsMap = new Map([...tagsMap.entries()].sort((a, b) => a[1] - b[1]));
// console.log(sortedTagsMap); 

const sortedTagsMap = new Map(
  [...tagsMap].sort((a, b) => a[0].localeCompare(b[0])),
);
// console.log(sortedTagsMap); 

const $ul = document.querySelector('ul[data-container="available-tags"]');
for (const [key, value] of sortedTagsMap) {
  let fragmentHTML = `<li>
<button data-tag="${key}">${key} (${value})</button>
</li>`;
  $ul.insertAdjacentHTML("beforeend", fragmentHTML);
}

let $activeTagButton; let cssIndex = -1; let headingIndex;
const styleEl = document.createElement("style");
document.head.appendChild(styleEl);
const styleSheet = styleEl.sheet;
window.xyStyleSheet = styleSheet;

$ul.addEventListener('click', (event) => {
  let $btn = event.target.closest('button');
  if ( ! $btn ) { return; }
  let filterByTag;
  if ( $activeTagButton ) {
    $activeTagButton.classList.remove('active');
  }
  if ( cssIndex > -1 ) { 
    styleSheet.deleteRule(cssIndex);
    styleSheet.deleteRule(headingIndex);
    cssIndex = headingIndex = -1;
  }
  console.log("<click>", $activeTagButton, $btn);
  if ( $activeTagButton && $activeTagButton.dataset.tag == $btn.dataset.tag ) {
    // toggling off
    $activeTagButton = null;
  } else {
    let cssRule = `.archive-group > div[data-tags*="${$btn.dataset.tag}"] { display: flex; }`;
    console.log("+", cssRule);
    cssIndex = styleSheet.insertRule(cssRule);
    let headingRule = `.archive-group h3:has(~ div[data-tags*="${$btn.dataset.tag}"]) { display: block; }`;
    console.log(headingRule);
    headingIndex = styleSheet.insertRule(headingRule);
    $activeTagButton = $btn;
    $btn.classList.add('active');
  }
})