import { useState, FormEvent, useEffect } from 'react';
import { supabase } from '../../config/supabase';
import { useNavigate } from 'react-router-dom';
import { CustomerHeader } from '../components/customer/CustomerHeader';

const Support = () => {
  const navigate = useNavigate();
  const [userData, setUserData] = useState<{
    id: string;
    first_name: string;
    last_name: string;
    email: string;
  } | null>(null);
  const [email, setEmail] = useState('');
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState(false);

  useEffect(() => {
    const checkAuth = async () => {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) {
        navigate('/customer-signup?from=support');
        return;
      }

      const { data: userProfile } = await supabase
        .from('customers')
        .select('id, first_name, last_name, email')
        .eq('id', session.user.id)
        .single();

      if (userProfile) {
        setUserData(userProfile);
      }
      if (session.user?.email) {
        setEmail(session.user.email);
      }
    };
    
    checkAuth();
  }, [navigate]);

  const validateForm = () => {
    if (!userData) return 'Please sign in to create a ticket';
    if (!title) return 'Title is required';
    if (!description) return 'Description is required';
    return '';
  };

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    if (!userData) return;
    
    setError('');
    setSuccess(false);
    
    const validationError = validateForm();
    if (validationError) {
      setError(validationError);
      return;
    }

    setIsSubmitting(true);

    try {
      const { data: insertedTicket, error: insertError } = await supabase
        .from('tickets')
        .insert({
          title,
          description,
          status: 'new',
          priority: 'medium',
          source_channel: 'web',
          created_by: userData.id,
          customer_email: email,
          tags: [],
          custom_fields: {},
          assigned_to: [],
          ticket_history: {
            events: [{
              id: crypto.randomUUID(),
              type: 'message',
              content: description,
              created_at: new Date().toISOString(),
              created_by_uuid: userData.id,
              created_by_first_name: userData.first_name,
              created_by_last_name: userData.last_name,
              visibility: 'public',
              attachments: []
            }]
          },
          internal_notes: { notes: [] },
          feedback: { rating: 0, comment: '', submitted_at: null }
        })
        .select()

      if (insertError) throw insertError;

      // Get the appropriate API URL based on environment
      const apiUrl = import.meta.env.MODE === 'production' 
        ? import.meta.env.VITE_API_URL_PROD 
        : import.meta.env.VITE_API_URL_DEV;

      // Include the Supabase ticket ID in the FastAPI request
      const ticketData = {
        id: insertedTicket[0].id,
        title,
        description,
        status: 'new',
        priority: 'medium',
        source_channel: 'web',
        created_by: userData.id,
        customer_email: email,
        tags: [],
        custom_fields: {},
        assigned_to: [],
        ticket_history: {
          events: [{
            id: crypto.randomUUID(),
            type: 'message',
            content: description,
            created_at: new Date().toISOString(),
            created_by_uuid: userData.id,
            created_by_first_name: userData.first_name,
            created_by_last_name: userData.last_name,
            visibility: 'public',
            attachments: []
          }]
        },
        internal_notes: { notes: [] },
        feedback: { rating: 0, comment: '', submitted_at: null }
      };

      // Fire-and-forget POST request
      fetch(`${apiUrl}/tickets/assign-to-agent`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(ticketData),
      }).catch(err => {
        // Silent error handling - log only
        console.error('FastAPI sync error (non-blocking):', err);
      });

      setSuccess(true);
      setTitle('');
      setDescription('');
    } catch (err) {
      setError('Failed to create ticket. Please try again.');
      console.error('Error creating ticket:', err);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="min-h-screen bg-gray-50">
      <CustomerHeader 
        firstName={userData?.first_name}
        lastName={userData?.last_name}
      />
      <div className="py-12">
        <div className="max-w-2xl mx-auto p-8 bg-white rounded-lg shadow">
          <h1 className="text-3xl font-semibold text-gray-900 mb-8">
            Submit a request
          </h1>

          {error && (
            <div className="mb-4 p-4 text-red-700 bg-red-100 rounded-md">
              {error}
            </div>
          )}

          {success && (
            <div className="mb-4 p-4 text-green-700 bg-green-100 rounded-md">
              Ticket created successfully! We'll get back to you soon.
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-6">
            {/* Email Field */}
            <div>
              <label htmlFor="email" className="block text-sm font-medium text-gray-700">
                Your email address
              </label>
              <input
                type="email"
                id="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-teal-500 focus:outline-none focus:ring-1 focus:ring-teal-500"
              />
            </div>

            {/* Title Field */}
            <div>
              <label htmlFor="subject" className="block text-sm font-medium text-gray-700">
                Title
              </label>
              <input
                type="text"
                id="subject"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                className="mt-1 block w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:border-teal-500 focus:outline-none focus:ring-1 focus:ring-teal-500"
              />
            </div>

            {/* Description Field */}
            <div>
              <label htmlFor="description" className="block text-sm font-medium text-gray-700">
                Description
              </label>
              {/* Toolbar */}
              <div className="mt-1 flex gap-2 p-2 border border-gray-300 border-b-0 rounded-t-md bg-white">
                <button type="button" className="p-1 hover:bg-gray-100 rounded">T</button>
                <button type="button" className="p-1 hover:bg-gray-100 rounded font-bold">B</button>
                <button type="button" className="p-1 hover:bg-gray-100 rounded italic">I</button>
                <button type="button" className="p-1 hover:bg-gray-100 rounded">•</button>
                <button type="button" className="p-1 hover:bg-gray-100 rounded">1.</button>
                <button type="button" className="p-1 hover:bg-gray-100 rounded">🖼</button>
                <button type="button" className="p-1 hover:bg-gray-100 rounded">🔗</button>
                <button type="button" className="p-1 hover:bg-gray-100 rounded">"</button>
              </div>
              <textarea
                id="description"
                value={description}
                onChange={(e) => setDescription(e.target.value)}
                rows={8}
                className="mt-1 block w-full rounded-md border border-gray-300 shadow-sm focus:border-teal-500 focus:outline-none focus:ring-1 focus:ring-teal-500 p-4"
              />
              <p className="mt-2 text-sm text-gray-500">
                Please enter the details of your request. A member of our support staff will respond as soon as possible.
              </p>
            </div>

            {/* Attachments */}
            <div>
              <label className="block text-sm font-medium text-gray-700">
                Attachments (optional)
              </label>
              <div className="mt-1 flex justify-center px-6 py-10 border-2 border-gray-300 border-dashed rounded-md">
                <div className="text-center">
                  <button
                    type="button"
                    className="text-blue-600 hover:text-blue-700 font-medium focus:outline-none"
                  >
                    Add file
                  </button>
                  <span className="text-gray-500"> or drop files here</span>
                </div>
              </div>
            </div>

            {/* Submit Button */}
            <div>
              <button
                type="submit"
                disabled={isSubmitting}
                className="w-full bg-teal-800 text-white py-2 px-4 rounded-md hover:bg-teal-900 focus:outline-none focus:ring-2 focus:ring-teal-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                {isSubmitting ? 'Submitting...' : 'Submit'}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
};

export default Support;
