import { ClockIcon, AcademicCapIcon, BuildingOfficeIcon } from '@heroicons/react/24/outline';

const features = [
  {
    name: '12-Week Intensive Program',
    description: 'Transform into an elite AI engineer with our 12-week program - 4 weeks remote followed by 8 weeks in Austin, Texas. Work 80-100 hours per week in a Stanford-level AI education environment.',
    icon: ClockIcon,
  },
  {
    name: 'Free Program + Guaranteed Job',
    description: 'Participate in our program completely free of charge. Upon successful completion, receive a guaranteed $200,000/year job offer as an AI Engineer in Austin, Texas.',
    icon: AcademicCapIcon,
  },
  {
    name: 'Elite Training Environment',
    description: 'Join our competitive, survival-like environment where you will rapidly rebuild complex applications using modern AI tools, focusing on speed, quality, and scalability.',
    icon: BuildingOfficeIcon,
  },
];

export const SupportFeatures = () => {
  return (
    <div className="py-12 bg-gray-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center">
          <h2 className="text-3xl font-bold text-gray-900">
            Transform Into an Elite AI Engineer
          </h2>
          <p className="mt-4 text-lg text-gray-500">
            Gauntlet AI is your path to becoming a high-caliber AI builder and entrepreneur
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
