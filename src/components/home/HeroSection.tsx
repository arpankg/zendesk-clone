import { Link } from 'react-router-dom';

export const HeroSection = () => {
  return (
    <div className="relative bg-white">
      {/* Background pattern */}
      <div className="absolute inset-0 z-0">
        <div className="absolute inset-0" style={{ opacity: 0.05 }}>
          <svg width="100%" height="100%">
            <pattern id="dots" x="0" y="0" width="24" height="24" patternUnits="userSpaceOnUse">
              <circle cx="2" cy="2" r="1" fill="currentColor" />
            </pattern>
            <rect width="100%" height="100%" fill="url(#dots)" />
          </svg>
        </div>
      </div>

      <div className="max-w-[1400px] mx-auto">
        <div className="relative z-10 pt-20 pb-16 lg:pt-32 lg:pb-28 lg:w-[65%]">
          <div className="px-20">
            <h1 className="text-[80px] leading-[1.1] tracking-tight font-black">
              <span className="block pr-20">WELCOME TO GAUNTLET AI SUPPORT</span>
            </h1>
            <p className="mt-8 max-w-[600px] text-[18px] leading-relaxed text-gray-600">
              Get the help you need with our comprehensive support system. Access
              documentation, submit tickets, and connect with our support team.
            </p>
            <div className="mt-10 flex flex-wrap gap-4">
              <Link
                to="/support"
                className="inline-flex px-8 py-3 text-[15px] font-medium bg-black text-white rounded-md hover:bg-gray-900 transition-colors duration-200"
              >
                Get Help
              </Link>
              <Link
                to="/knowledge-base"
                className="inline-flex px-8 py-3 text-[15px] font-medium text-black hover:bg-gray-50 rounded-md transition-colors duration-200"
              >
                Browse Knowledge Base
              </Link>
            </div>
          </div>
        </div>
      </div>

      {/* Image section */}
      <div className="absolute top-[55%] right-[10%] transform -translate-y-1/2 hidden lg:block">
        <div className="relative w-[400px] h-[400px]">
          <img
            className="w-full h-full object-contain"
            src="/homepage_cover_image.png"
            alt="Gauntlet AI Globe Illustration"
          />
        </div>
      </div>
    </div>
  );
};
