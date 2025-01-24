import { CustomerHeader } from '../components/customer/CustomerHeader';

const KnowledgeBase = () => {
  return (
    <div className="min-h-screen bg-gray-50">
      <CustomerHeader />
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h1 className="text-3xl font-bold text-gray-900 mb-4">Knowledge Base</h1>
        <p className="text-gray-600">Welcome to our Knowledge Base. Content coming soon.</p>
      </div>
    </div>
  );
};

export default KnowledgeBase;
