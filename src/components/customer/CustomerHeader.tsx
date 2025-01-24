import React from 'react';

interface CustomerHeaderProps {
  className?: string;
}

export const CustomerHeader: React.FC<CustomerHeaderProps> = ({ className = '' }) => {
  return (
    <header className={`bg-white border-b border-gray-200 shadow-sm ${className}`}>
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <span className="text-gray-900 font-medium">Welcome, John Doe</span>
          <span className="text-sm text-gray-500">john@example.com</span>
        </div>
        <button className="text-gray-600 hover:text-gray-900 font-medium px-4 py-2 rounded-md hover:bg-gray-50 transition-colors">
          Sign Out
        </button>
      </div>
    </header>
  );
};
