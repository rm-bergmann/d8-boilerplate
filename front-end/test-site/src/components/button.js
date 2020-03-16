import React from 'react';

const Button = ({ buttonText }) => (
  <button
    style={{
      background: `purple`,
      margin: `1rem`,
      width: `80%`,
      height: `60px`,
      color: `white`,
    }}
  >{buttonText}
  </button>
);

export default Button;
