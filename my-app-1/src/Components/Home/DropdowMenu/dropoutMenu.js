import React, { useState } from "react";
import { AiOutlineDown } from "react-icons/ai";
import "./dropoutmenu.scss";

function DropdownMenu({ title, items }) {
  const [isOpen, setIsOpen] = useState(false);

  const toggleDropdown = () => setIsOpen(!isOpen);

  return (
    <li
      className="menu-item"
      onMouseEnter={() => setIsOpen(true)}
      onMouseLeave={() => setIsOpen(false)}
    >
      <a href="#" className="menu-link">
        {title}
        <span className="dropdown-icon">
          <AiOutlineDown />
        </span>
      </a>
      {isOpen && (
        <ul className="dropdown-list">
          {items.map((item, index) => (
            <li key={index} className="dropdown-item">
              <a href={item.link} className="dropdown-link">
                {item.label}
              </a>
            </li>
          ))}
        </ul>
      )}
    </li>
  );
}

export default DropdownMenu;
