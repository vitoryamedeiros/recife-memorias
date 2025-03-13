import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { AuthProvider } from "@/hooks/use-auth";
import Index from "./pages/Index";
import NotFound from "./pages/NotFound";
import Locations from "./pages/Locations";
import Location from "./pages/Location";
import Story from "./pages/Story";
import AuthCallback from "./pages/AuthCallback";
import Profile from "./pages/Profile";
import Dashboard from "./pages/Dashboard";
import AdminLocations from "@/pages/AdminLocations";
import AdminDashboard from '@/pages/AdminDashboard';
import AdminStories from '@/pages/AdminStories';
import AdminUsers from '@/pages/AdminUsers';
import AdminComments from '@/pages/AdminComments';
import AdminReports from '@/pages/AdminReports';
import AdminLocationForm from '@/pages/AdminLocationForm';
import AdminSettings from '@/pages/AdminSettings';
import AdminLocationsList from '@/pages/AdminLocationsList';
import SetAdmin from '@/pages/SetAdmin';

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <AuthProvider>
      <TooltipProvider>
        <Toaster />
        <Sonner />
        <BrowserRouter>
          <Routes>
            <Route path="/" element={<Index />} />
            <Route path="/locations" element={<Locations />} />
            <Route path="/location/:id" element={<Location />} />
            <Route path="/story/:id" element={<Story />} />
            <Route path="/auth/callback" element={<AuthCallback />} />
            <Route path="/profile" element={<Profile />} />
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/admin/locations" element={<AdminLocationsList />} />
            <Route path="/admin/dashboard" element={<AdminDashboard />} />
            <Route path="/admin/stories" element={<AdminStories />} />
            <Route path="/admin/users" element={<AdminUsers />} />
            <Route path="/admin/comments" element={<AdminComments />} />
            <Route path="/admin/reports" element={<AdminReports />} />
            <Route path="/admin/settings" element={<AdminSettings />} />
            <Route path="/admin/locations/new" element={<AdminLocationForm />} />
            <Route path="/admin/locations/edit/:id" element={<AdminLocationForm />} />
            <Route path="/set-admin" element={<SetAdmin />} />
            {/* ADD ALL CUSTOM ROUTES ABOVE THE CATCH-ALL "*" ROUTE */}
            <Route path="*" element={<NotFound />} />
          </Routes>
        </BrowserRouter>
      </TooltipProvider>
    </AuthProvider>
  </QueryClientProvider>
);

export default App;
