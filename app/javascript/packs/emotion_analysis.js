document.addEventListener('turbolinks:load', function() {
  var modal = document.getElementById('emotion-analysis-modal');
  var modalBg = document.getElementById('modal-background');

  document.getElementById('show-modal-btn').addEventListener('click', function(event) {
    event.preventDefault();
    // modalとmodalの背景を表示
    modal.style.display = 'block';
    modalBg.style.display = 'block';
  });

  document.getElementById('close-modal-btn').addEventListener('click', function() {
     // modalとmodalの背景を非表示
    modal.style.display = 'none';
    modalBg.style.display = 'none';
  });
});