import starTrekProductions from '../dicts/startrek';

export default function generateEpisode(symbol = '<start>') {
  const episode = getRandomProduction(symbol);

  if (episode.indexOf('<') >= 0) {
    const words = episode.split(' ');
    for (let i = 0; i < words.length; i++) {
      if (words[i].indexOf('<') >= 0) {
        words[i] = generateEpisode(words[i]);
      }
    }
    console.log(words);
    return words.join(' ');
  }
  console.log(episode);
  return episode;
}

function getRandomProduction(nonTerminal) {
  console.log(nonTerminal);
  const list = starTrekProductions[nonTerminal];
  console.log(list);
  
  const size = list.length;
  const randomIndex = getRandomInt(size);
  const randomProd = list[randomIndex];
  console.log(randomIndex);
  console.log(randomProd);
  return randomProd;
}

function getRandomInt(max) {
  return Math.floor(Math.random() * Math.floor(max));
}
