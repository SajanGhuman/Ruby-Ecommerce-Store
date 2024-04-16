document.addEventListener("DOMContentLoaded", function() {
    const navToggle = document.getElementById("nav-toggle");
    const navContent = document.getElementById("nav-content");

    navToggle.addEventListener("click", function() {
      navContent.classList.toggle("hidden");
    });
  });
