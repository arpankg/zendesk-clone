import { useState, FormEvent } from 'react';
import { supabase } from '../../config/supabase';
import { useNavigate } from 'react-router-dom';
import cityTimezones from 'city-timezones';
import { Combobox } from '@headlessui/react';

// Format city data for the combobox
const locationOptions = cityTimezones.cityMapping.map(city => ({
  value: `${city.city}${city.province ? `, ${city.province}` : ''}, ${city.country}`,
  label: `${city.city}${city.province ? `, ${city.province}` : ''}, ${city.country}`,
  timezone: city.timezone
}));

const EmployeeSignUp = () => {
  const navigate = useNavigate();
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [location, setLocation] = useState<string>('');
  const [query, setQuery] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState('');

  const filteredLocations = query === ''
    ? []
    : locationOptions
        .filter(loc => 
          loc.label.toLowerCase().includes(query.toLowerCase()))
        .slice(0, 10);

  // Function to get timezone from location
  const getTimezoneFromLocation = async (location: string): Promise<string> => {
    try {
      // First check if it's one of our predefined locations
      const locationOption = locationOptions.find(opt => opt.value === location);
      if (locationOption) {
        return locationOption.timezone;
      }

      // If not found in our options, try to find the city
      const cityLookup = cityTimezones.findFromCityStateProvince(location);
      
      if (cityLookup && cityLookup.length > 0) {
        return cityLookup[0].timezone;
      }

      // If city not found, try to find by country ISO code
      const countries = require('country-list');
      const countryCode = countries.getCode(location);
      if (countryCode) {
        const countryLookup = cityTimezones.findFromIsoCode(countryCode);
        if (countryLookup && countryLookup.length > 0) {
          return countryLookup[0].timezone;
        }
      }

      // If all else fails, use browser's timezone
      console.warn('Could not find timezone for location:', location);
      return Intl.DateTimeFormat().resolvedOptions().timeZone;
    } catch (error) {
      console.error('Error getting timezone:', error);
      return Intl.DateTimeFormat().resolvedOptions().timeZone;
    }
  };

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setError('');

    try {
      const timezone = await getTimezoneFromLocation(location);

      // Sign up with Supabase Auth
      const { data: authData, error: authError } = await supabase.auth.signUp({
        email,
        password,
      });

      if (authError) throw authError;

      if (authData.user) {
        // Create worker record
        const { error: workerError } = await supabase
          .from('workers')
          .insert({
            id: authData.user.id,
            first_name: firstName,
            last_name: lastName,
            email: email,
            role: 'agent',
            timezone: timezone,
            skills: [],
            languages: ['en'],
            metrics: {}
          });

        if (workerError) throw workerError;

        // Redirect to employee dashboard
        navigate('/employee-dashboard');
      }
    } catch (err) {
      console.error('Error during sign up:', err);
      setError(err instanceof Error ? err.message : 'Failed to create account');
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleLocationChange = (value: string | null) => {
    setLocation(value || '');
  };

  return (
    <div className="min-h-screen bg-gray-50 py-12">
      <div className="max-w-2xl mx-auto p-8 bg-white rounded-lg shadow">
        <h1 className="text-3xl font-semibold text-gray-900 mb-2">
          Create Your Employee Account
        </h1>
        <p className="text-gray-600 mb-8">
          Sign up to start helping customers and managing support tickets
        </p>

        {error && (
          <div className="mb-4 p-4 text-red-700 bg-red-100 rounded-md">
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-6">
          {/* First Name Field */}
          <div>
            <label htmlFor="firstName" className="block text-sm font-medium text-gray-700">
              First Name
            </label>
            <input
              type="text"
              id="firstName"
              value={firstName}
              onChange={(e) => setFirstName(e.target.value)}
              className="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-teal-500 focus:outline-none focus:ring-1 focus:ring-teal-500"
              required
            />
          </div>

          {/* Last Name Field */}
          <div>
            <label htmlFor="lastName" className="block text-sm font-medium text-gray-700">
              Last Name
            </label>
            <input
              type="text"
              id="lastName"
              value={lastName}
              onChange={(e) => setLastName(e.target.value)}
              className="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-teal-500 focus:outline-none focus:ring-1 focus:ring-teal-500"
              required
            />
          </div>

          {/* Email Field */}
          <div>
            <label htmlFor="email" className="block text-sm font-medium text-gray-700">
              Email
            </label>
            <input
              type="email"
              id="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-teal-500 focus:outline-none focus:ring-1 focus:ring-teal-500"
              required
            />
          </div>

          {/* Password Field */}
          <div>
            <label htmlFor="password" className="block text-sm font-medium text-gray-700">
              Password
            </label>
            <input
              type="password"
              id="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-teal-500 focus:outline-none focus:ring-1 focus:ring-teal-500"
              required
            />
          </div>

          {/* Location Field */}
          <div className="relative">
            <label htmlFor="location" className="block text-sm font-medium text-gray-700">
              Location (City, Country)
            </label>
            <Combobox value={location} onChange={handleLocationChange}>
              <div className="relative mt-1">
                <Combobox.Input
                  className="w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-teal-500 focus:outline-none focus:ring-1 focus:ring-teal-500"
                  onChange={(event) => setQuery(event.target.value)}
                  displayValue={(loc: string) => loc}
                  placeholder="e.g., New York, USA"
                />
                <Combobox.Options className="absolute z-10 mt-1 max-h-60 w-full overflow-auto rounded-md bg-white py-1 text-base shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none sm:text-sm">
                  {filteredLocations.length === 0 && query !== '' ? (
                    <div className="relative cursor-default select-none px-4 py-2 text-gray-700">
                      Nothing found.
                    </div>
                  ) : (
                    filteredLocations.map((location) => (
                      <Combobox.Option
                        key={location.value}
                        value={location.value}
                        className={({ active }) =>
                          `relative cursor-default select-none py-2 pl-4 pr-4 ${
                            active ? 'bg-teal-600 text-white' : 'text-gray-900'
                          }`
                        }
                      >
                        {location.label}
                      </Combobox.Option>
                    ))
                  )}
                </Combobox.Options>
              </div>
            </Combobox>
          </div>

          {/* Submit Button */}
          <div>
            <button
              type="submit"
              disabled={isSubmitting}
              className="w-full bg-teal-800 text-white py-2 px-4 rounded-md hover:bg-teal-900 focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {isSubmitting ? 'Creating Account...' : 'Create Employee Account'}
            </button>
          </div>

          {/* Links */}
          <div className="text-sm text-center">
            <p className="text-gray-600">
              Already have an account?{' '}
              <a href="/employee-login" className="text-teal-600 hover:text-teal-800">
                Sign in
              </a>
            </p>
          </div>
        </form>
      </div>
    </div>
  );
};

export default EmployeeSignUp;
