$(document).on('turbolinks:load', function() {
  var discardBtn = document.getElementById("discard-btn");
  var keepBtn = document.getElementById("keep-btn");
  var eitherBtn = document.getElementById("either-btn");

  if (discardBtn != null) {
    discardBtn.addEventListener('click', function() {
      discardBtn.classList.add('active');
      keepBtn.classList.remove('active');
      eitherBtn.classList.remove('active');
    });

    keepBtn.addEventListener('click', function() {
      keepBtn.classList.add('active');
      discardBtn.classList.remove('active');
      eitherBtn.classList.remove('active');
    });

    eitherBtn.addEventListener('click', function() {
      eitherBtn.classList.add('active');
      discardBtn.classList.remove('active');
      keepBtn.classList.remove('active');
    });
  }
});

