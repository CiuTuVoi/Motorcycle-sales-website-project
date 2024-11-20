
import React, { useState } from 'react';
import { AiOutlineDown } from "react-icons/ai";
import './dropoutmenu.scss';

function DropdownMenu({ title, items }) {
  const [isOpen, setIsOpen] = useState(false);

  const toggleDropdown = () => setIsOpen(!isOpen);

  return (
    <li className="menu-item" onMouseEnter={toggleDropdown} onMouseLeave={toggleDropdown}>
      <a href="">{title}</a>
      <span className="dropdown-icon"><AiOutlineDown /></span>
      {isOpen && (
        <ul className="dropdown-list">
          {items.map((item, index) => (
            <li key={index} className="dropdown-item">
              <a href={item.link}>{item.label}</a>
            </li>
          ))}
        </ul>
      )}
    </li>
  );
}

export default DropdownMenu;
