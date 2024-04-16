// app/assets/javascripts/payment.js
document.addEventListener('DOMContentLoaded', function() {
    var stripe = Stripe('<%= Rails.application.credentials.stripe[:publishable_key] %>');
    var elements = stripe.elements();
  
    var cardElement = elements.create('card');
    cardElement.mount('#card-element');
    
    var form = document.getElementById('payment-form');
  
    form.addEventListener('submit', function(event) {
      event.preventDefault();
  
      stripe.createPaymentMethod({
        type: 'card',
        card: cardElement,
      }).then(function(result) {
        if (result.error) {
          console.error(result.error.message);
        } else {
          // Payment method created successfully
          // Handle payment submission to your server
          var paymentMethodId = result.paymentMethod.id;
          submitPayment(paymentMethodId);
        }
      });
    });
  
    function submitPayment(paymentMethodId) {
      var form = document.getElementById('payment-form');
      var hiddenInput = document.createElement('input');
      hiddenInput.setAttribute('type', 'hidden');
      hiddenInput.setAttribute('name', 'payment_method_id');
      hiddenInput.setAttribute('value', paymentMethodId);
      form.appendChild(hiddenInput);
      form.submit();
    }
  });
  