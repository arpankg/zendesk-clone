import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { supabase } from '../../../config/supabase';

interface CustomerHeaderProps {
  className?: string;
}

export const CustomerHeader: React.FC<CustomerHeaderProps> = ({ className = '' }) => {
  const navigate = useNavigate();
  const [isSigningOut, setIsSigningOut] = useState(false);

  const handleSignOut = async () => {
    try {
      setIsSigningOut(true);
      const { error } = await supabase.auth.signOut();
      if (error) throw error;
      navigate('/');
    } catch (err) {
      console.error('Error signing out:', err);
    } finally {
      setIsSigningOut(false);
    }
  };

  return (
    <header className={`bg-white border-b border-gray-200 shadow-sm ${className}`}>
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
        <div className="flex items-center gap-8">
          <span className="text-gray-900 font-medium">Welcome, John Doe</span>
          <nav className="flex gap-6">
            <Link to="/" className="text-gray-600 hover:text-gray-900">Home</Link>
            <Link to="/customer-dashboard" className="text-gray-600 hover:text-gray-900">Dashboard</Link>
            <Link to="/knowledge-base" className="text-gray-600 hover:text-gray-900">Knowledge Base</Link>
          </nav>
        </div>
        <button 
          onClick={handleSignOut}
          disabled={isSigningOut}
          className="text-gray-600 hover:text-gray-900 font-medium px-4 py-2 rounded-md hover:bg-gray-50 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {isSigningOut ? 'Signing Out...' : 'Sign Out'}
        </button>
      </div>
    </header>
  );
};
