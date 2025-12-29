import { useEffect, useState } from 'react';

function App() {
  const [health, setHealth] = useState(null);

  useEffect(() => {
    fetch('/health.json')
      .then(res => res.json())
      .then(data => setHealth(data))
      .catch(err => console.error(err));
  }, []);

  return (
    <div>
      <h1>App Status</h1>
      {health ? <p>Status: {health.status}</p> : <p>Loading...</p>}
    </div>
  );
}

export default App;
