import React, { useState } from "react";

import Layout from "../components/layout";
import SEO from "../components/seo";
import generateEpisode from '../utils/utils';
import "../css/app.css"

const IndexPage = () => {
  const [episode, setEpisode] = useState('');

  function getEpisode() {
    setEpisode(generateEpisode());
  }
  
  return (
      <Layout>
        <SEO/>
        <div className='app-wrapper'>
          <div className='app'>
            <button
              className='generate-button'
              onClick={() => getEpisode()}
            >
              Generate a random Star Trek episode!
            </button>
            <div className='episode'>
              <span>{episode}</span>
            </div>
          </div>
        </div>
      </Layout>
    
  );
}

export default IndexPage
