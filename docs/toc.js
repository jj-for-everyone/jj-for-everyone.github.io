// Populate the sidebar
//
// This is a script, and not included directly in the page, to control the total size of the book.
// The TOC contains an entry for each page, so if each page includes a copy of the TOC,
// the total size of the page becomes O(n**2).
class MDBookSidebarScrollbox extends HTMLElement {
    constructor() {
        super();
    }
    connectedCallback() {
        this.innerHTML = '<ol class="chapter"><li class="chapter-item expanded "><a href="introduction.html">Introduction</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="structure.html">How to read this tutorial</a></li><li class="chapter-item expanded "><a href="watch_releases.html">Stay up to date</a></li><li class="chapter-item expanded "><a href="contribute.html">Help make this tutorial better</a></li><li class="chapter-item expanded "><a href="terminal_basics.html">Terminal basics</a></li></ol></li><li class="chapter-item expanded "><a href="level_1.html">Level 1</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="install.html">Installation and setup</a></li><li class="chapter-item expanded "><a href="initialize.html">Initializing a repository</a></li><li class="chapter-item expanded "><a href="log.html">Inspecting the state of a repository</a></li><li class="chapter-item expanded "><a href="make_changes.html">Making changes</a></li><li class="chapter-item expanded "><a href="commit.html">Creating a new commit</a></li><li class="chapter-item expanded "><a href="remote.html">Sending commits to a remote</a></li><li class="chapter-item expanded "><a href="update_bookmark.html">Updating bookmarks</a></li><li class="chapter-item expanded "><a href="clone.html">Cloning a remote</a></li><li class="chapter-item expanded "><a href="github.html">Using GitHub (optional)</a></li></ol></li><li class="chapter-item expanded "><a href="level_2.html">Level 2</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="branch.html">Branching history</a></li><li class="chapter-item expanded "><a href="show.html">Inspecting a commit</a></li><li class="chapter-item expanded "><a href="merge.html">Creating a merge commit</a></li><li class="chapter-item expanded "><a href="ignore.html">Excluding files from version control</a></li><li class="chapter-item expanded "><a href="rebase.html">Rebasing</a></li><li class="chapter-item expanded "><a href="more_bookmarks.html">Adding more bookmarks</a></li><li class="chapter-item expanded "><a href="navigate.html">Navigating the history</a></li></ol></li><li class="chapter-item expanded "><a href="level_3.html">Level 3</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="undo.html">Undoing mistakes</a></li><li class="chapter-item expanded "><a href="track.html">Tracking remote bookmarks</a></li><li class="chapter-item expanded "><a href="conflict.html">Resolving merge conflicts</a></li><li class="chapter-item expanded "><a href="abandon.html">Deleting commits and bookmarks</a></li><li class="chapter-item expanded "><a href="restore.html">Restoring file contents</a></li><li class="chapter-item expanded "><a href="commit_interactive.html">Split a messy working copy</a></li></ol></li><li class="chapter-item expanded "><a href="to_be_continued.html">Must-know secret commands</a></li></ol>';
        // Set the current, active page, and reveal it if it's hidden
        let current_page = document.location.href.toString().split("#")[0].split("?")[0];
        if (current_page.endsWith("/")) {
            current_page += "index.html";
        }
        var links = Array.prototype.slice.call(this.querySelectorAll("a"));
        var l = links.length;
        for (var i = 0; i < l; ++i) {
            var link = links[i];
            var href = link.getAttribute("href");
            if (href && !href.startsWith("#") && !/^(?:[a-z+]+:)?\/\//.test(href)) {
                link.href = path_to_root + href;
            }
            // The "index" page is supposed to alias the first chapter in the book.
            if (link.href === current_page || (i === 0 && path_to_root === "" && current_page.endsWith("/index.html"))) {
                link.classList.add("active");
                var parent = link.parentElement;
                if (parent && parent.classList.contains("chapter-item")) {
                    parent.classList.add("expanded");
                }
                while (parent) {
                    if (parent.tagName === "LI" && parent.previousElementSibling) {
                        if (parent.previousElementSibling.classList.contains("chapter-item")) {
                            parent.previousElementSibling.classList.add("expanded");
                        }
                    }
                    parent = parent.parentElement;
                }
            }
        }
        // Track and set sidebar scroll position
        this.addEventListener('click', function(e) {
            if (e.target.tagName === 'A') {
                sessionStorage.setItem('sidebar-scroll', this.scrollTop);
            }
        }, { passive: true });
        var sidebarScrollTop = sessionStorage.getItem('sidebar-scroll');
        sessionStorage.removeItem('sidebar-scroll');
        if (sidebarScrollTop) {
            // preserve sidebar scroll position when navigating via links within sidebar
            this.scrollTop = sidebarScrollTop;
        } else {
            // scroll sidebar to current active section when navigating via "next/previous chapter" buttons
            var activeSection = document.querySelector('#sidebar .active');
            if (activeSection) {
                activeSection.scrollIntoView({ block: 'center' });
            }
        }
        // Toggle buttons
        var sidebarAnchorToggles = document.querySelectorAll('#sidebar a.toggle');
        function toggleSection(ev) {
            ev.currentTarget.parentElement.classList.toggle('expanded');
        }
        Array.from(sidebarAnchorToggles).forEach(function (el) {
            el.addEventListener('click', toggleSection);
        });
    }
}
window.customElements.define("mdbook-sidebar-scrollbox", MDBookSidebarScrollbox);
