import { ClockIcon, DocumentCheckIcon, ArrowPathIcon } from '@heroicons/react/24/outline';

const features = [
  {
    name: '24/7 Support',
    description: 'Our support team is available around the clock to help you with any issues you encounter.',
    icon: ClockIcon,
  },
  {
    name: 'Comprehensive Documentation',
    description: 'Access our detailed knowledge base to find answers to common questions and learn best practices.',
    icon: DocumentCheckIcon,
  },
  {
    name: 'Real-time Updates',
    description: 'Stay informed with real-time updates on your support tickets and requests.',
    icon: ArrowPathIcon,
  },
];

export const SupportFeatures = () => {
  return (
    <div className="py-12 bg-gray-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center">
          <h2 className="text-3xl font-bold text-gray-900">
            World-class Support
          </h2>
          <p className="mt-4 text-lg text-gray-500">
            Everything you need to get the help you deserve
          </p>
        </div>

        <div className="mt-10">
          <div className="grid grid-cols-1 gap-10 sm:grid-cols-2 lg:grid-cols-3">
            {features.map((feature) => (
              <div key={feature.name} className="pt-6">
                <div className="flow-root bg-white rounded-lg px-6 pb-8">
                  <div className="-mt-6">
                    <div>
                      <span className="inline-flex items-center justify-center p-3 bg-[#345fea] rounded-md shadow-lg">
                        <feature.icon className="h-6 w-6 text-white" aria-hidden="true" />
                      </span>
                    </div>
                    <h3 className="mt-8 text-lg font-medium text-gray-900 tracking-tight">
                      {feature.name}
                    </h3>
                    <p className="mt-5 text-base text-gray-500">
                      {feature.description}
                    </p>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};
