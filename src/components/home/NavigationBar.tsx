import { Link } from 'react-router-dom';

export const NavigationBar = () => {
  return (
    <nav className="fixed w-full bg-white z-50">
      <div className="max-w-7xl mx-auto px-8 py-4">
        <div className="flex items-center justify-between">
          {/* Logo */}
          <div className="flex-shrink-0">
            <Link to="/" className="flex items-center space-x-2">
              <img
                src="/navbar_image.png"
                alt="Gauntlet AI Logo"
                className="h-6 w-auto"
              />
              <span className="text-xl font-medium text-black">Gauntlet AI</span>
            </Link>
          </div>

          {/* Navigation Links */}
          <div className="hidden sm:flex sm:items-center space-x-8">
            <Link
              to="/knowledge-base"
              className="text-[15px] text-gray-600 hover:text-black transition-colors duration-200"
            >
              Knowledge Base
            </Link>
            <Link
              to="/support"
              className="text-[15px] text-gray-600 hover:text-black transition-colors duration-200"
            >
              Support
            </Link>
            <Link
              to="/employee-login"
              className="text-[15px] text-gray-600 hover:text-black transition-colors duration-200"
            >
              Employee Sign In
            </Link>
            <Link
              to="/employee-signup"
              className="text-[15px] bg-black text-white hover:bg-gray-900 px-4 py-2 rounded-md transition-colors duration-200"
            >
              Employee Sign Up
            </Link>
          </div>
        </div>
      </div>
    </nav>
  );
};
