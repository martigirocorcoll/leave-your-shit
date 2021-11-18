import places from 'places.js';

const initAutocomplete = () => {
  // const addressInput = document.getElementById('location_address');
  const addressForm = document.querySelector(".form-home-banner");
  if (addressForm) {
    places({ container: addressForm});
    // places({ container: addressInput });
  }
};

export { initAutocomplete };
