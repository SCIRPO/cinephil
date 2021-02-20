import "jquery-bar-rating";
import Rails from '@rails/ujs';
import $, { each } from 'jquery'; // <-- if you're NOT using a Le Wagon template (cf jQuery section)

const initStarRating = () => {
  $('.viewing_form').each(function() {
    $(this).find('.star_rating').barrating({
      theme: 'css-stars',
      onSelect: (value, text, event) => {
        console.log(this)
        Rails.fire(this, 'submit');
        // $(this).trigger('submit.rails'); // We submit the form with javascript
      }
    });
  });
};

export { initStarRating };