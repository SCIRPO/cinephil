import { CountUp } from 'countup.js';

const initCountup = () => {
  const stats = document.querySelector(".stats")
  if (stats) {
    const ids = ["series", "users", "episodes", "hours"]
    const statsNumbers = stats.querySelectorAll(".statistics-number")
    statsNumbers.forEach((statNumber) => {
      const countUp = new CountUp(statNumber.id, statNumber.dataset.count);
      if (!countUp.error) {
          countUp.start();
      } else {
          console.error(countUp.error);
      }
    })
  }
}

export default initCountup