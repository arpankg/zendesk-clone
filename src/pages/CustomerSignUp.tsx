import { useState, FormEvent } from 'react';
import { supabase } from '../../config/supabase';
import { useNavigate, useSearchParams } from 'react-router-dom';

const CustomerSignUp = () => {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const isFromSupport = searchParams.get('from') === 'support';

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);

    try {
      // Sign up with Supabase Auth
      const { data: authData, error: authError } = await supabase.auth.signUp({
        email,
        password,
      });

      if (authError) throw authError;

      if (authData.user) {
        // Create customer record
        const { error: customerError } = await supabase
          .from('customers')
          .insert({
            id: authData.user.id,
            first_name: firstName,
            last_name: lastName,
            email: email,
            communication_channels: ['web'],
            preferred_language: 'en',
            feedback_history: { feedback: [] }
          });

        if (customerError) throw customerError;

        // Redirect to support page if they came from there, otherwise to dashboard
        if (isFromSupport) {
          navigate('/support');
        } else {
          navigate('/customer-dashboard');
        }
      }
    } catch (err) {
      console.error('Error during sign up:', err);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 py-12">
      <div className="max-w-2xl mx-auto p-8 bg-white rounded-lg shadow">
        {isFromSupport && (
          <div className="mb-6 p-4 text-amber-700 bg-amber-50 border border-amber-200 rounded-md">
            You must be logged in to submit a support ticket. Please create an account or{' '}
            <a href="/customer-login" className="text-teal-600 hover:text-teal-800 underline">
              sign in
            </a>{' '}
            to continue.
          </div>
        )}

        <h1 className="text-3xl font-semibold text-gray-900 mb-2">
          Create Your Customer Account
        </h1>
        <p className="text-gray-600 mb-8">
          Sign up to manage your support tickets and get faster assistance
        </p>

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

          {/* Submit Button */}
          <div>
            <button
              type="submit"
              disabled={isSubmitting}
              className="w-full bg-teal-800 text-white py-2 px-4 rounded-md hover:bg-teal-900 focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {isSubmitting ? 'Creating Account...' : 'Create Customer Account'}
            </button>
          </div>

          {/* Links */}
          <div className="text-sm text-center space-y-2">
            <p className="text-gray-600">
              Already have an account?{' '}
              <a href="/customer-login" className="text-teal-600 hover:text-teal-800">
                Sign in
              </a>
            </p>
            <p>
              <a href="/support" className="text-teal-600 hover:text-teal-800">
                Submit a request without an account
              </a>
            </p>
          </div>
        </form>
      </div>
    </div>
  );
};

export default CustomerSignUp;
