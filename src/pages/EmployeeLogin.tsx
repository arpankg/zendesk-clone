import { useState, FormEvent } from 'react';
import { supabase } from '../../config/supabase';
import { useNavigate } from 'react-router-dom';

const EmployeeLogin = () => {
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState('');

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    setError('');

    try {
      const { data, error: signInError } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (signInError) throw signInError;

      if (data?.user) {
        // Check if user is an employee
        const { data: workerData, error: workerError } = await supabase
          .from('workers')
          .select('id')
          .eq('id', data.user.id)
          .single();

        if (workerError) throw workerError;

        if (!workerData) {
          throw new Error('No employee account found');
        }

        // Redirect to employee dashboard after successful login
        navigate('/employee-dashboard');
      }
    } catch (err) {
      console.error('Error during login:', err);
      setError('Invalid email or password');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 py-12">
      <div className="max-w-md mx-auto p-8 bg-white rounded-lg shadow">
        <h1 className="text-3xl font-semibold text-gray-900 mb-2">
          Employee Sign In
        </h1>
        <p className="text-gray-600 mb-8">
          Sign in to manage support tickets and help customers
        </p>

        {error && (
          <div className="mb-4 p-4 text-red-700 bg-red-100 rounded-md">
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-6">
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
              {isSubmitting ? 'Signing in...' : 'Sign in'}
            </button>
          </div>

          {/* Links */}
          <div className="text-sm text-center">
            <p className="text-gray-600">
              Don't have an employee account?{' '}
              <a href="/employee-signup" className="text-teal-600 hover:text-teal-800">
                Sign up
              </a>
            </p>
          </div>
        </form>
      </div>
    </div>
  );
};

export default EmployeeLogin;
