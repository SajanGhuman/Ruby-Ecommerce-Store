// Place this JavaScript in the appropriate asset file or within a <script> tag

document.addEventListener('DOMContentLoaded', function() {
    const categoryFieldsContainer = document.getElementById('category_fields');
    const addCategoryButton = document.getElementById('add_category_button');
  
    addCategoryButton.addEventListener('click', function() {
      const newCategoryField = document.createElement('div');
      newCategoryField.innerHTML = '<%= j render partial: "category_fields", locals: { f: f } %>';
      
      categoryFieldsContainer.appendChild(newCategoryField);
    });
  });
  