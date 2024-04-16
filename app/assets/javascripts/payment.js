// app/assets/javascripts/payment.js

document.addEventListener("DOMContentLoaded", function() {
    var stripe = Stripe('pk_test_51P653TRsxxc3eVDFtvIEPyRAK8JrxMl56r51h6CQ0pAh0QtTNfWaZoNRbTXOammZeehqCukF8iAVIW9NpTuQyf3P00jgu8fPCq'); // Replace with your Stripe publishable key
    var elements = stripe.elements();
  
    var cardElement = elements.create('card');
    cardElement.mount('#card-element');
  
    var cardErrors = document.getElementById('card-errors');
  
    var form = document.getElementById('payment-form');
  
    form.addEventListener('submit', function(event) {
      event.preventDefault();
  
      stripe.createToken(cardElement).then(function(result) {
        if (result.error) {
          cardErrors.textContent = result.error.message;
        } else {
          // Insert the token ID into the form so it gets submitted to the server
          var hiddenInput = document.createElement('input');
          hiddenInput.setAttribute('type', 'hidden');
          hiddenInput.setAttribute('name', 'stripeToken');
          hiddenInput.setAttribute('value', result.token.id);
          form.appendChild(hiddenInput);
  
          // Submit the form
          form.submit();
        }
      });
    });
  });
  