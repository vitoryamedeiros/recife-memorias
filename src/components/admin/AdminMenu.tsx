import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { Shield, MapPin, BookOpen, Users, MessageSquare, PieChart, Settings } from 'lucide-react';
import { cn } from '@/lib/utils';

const AdminMenu = () => {
  const location = useLocation();
  
  const menuItems = [
    {
      title: 'Painel Admin',
      path: '/admin/dashboard',
      icon: <Shield className="h-5 w-5" />
    },
    {
      title: 'Gerenciar Locais',
      path: '/admin/locations',
      icon: <MapPin className="h-5 w-5" />
    },
    {
      title: 'Gerenciar Histórias',
      path: '/admin/stories',
      icon: <BookOpen className="h-5 w-5" />
    },
    {
      title: 'Gerenciar Usuários',
      path: '/admin/users',
      icon: <Users className="h-5 w-5" />
    },
    {
      title: 'Gerenciar Comentários',
      path: '/admin/comments',
      icon: <MessageSquare className="h-5 w-5" />
    },
    {
      title: 'Relatórios',
      path: '/admin/reports',
      icon: <PieChart className="h-5 w-5" />
    },
    {
      title: 'Configurações',
      path: '/admin/settings',
      icon: <Settings className="h-5 w-5" />
    }
  ];
  
  return (
    <div className="bg-white rounded-lg shadow-md p-4 mb-6">
      <h2 className="text-lg font-bold text-recife-primary mb-4">Menu Administrativo</h2>
      <nav className="space-y-1">
        {menuItems.map((item) => (
          <Link
            key={item.path}
            to={item.path}
            className={cn(
              "flex items-center px-4 py-3 text-sm font-medium rounded-md transition-colors",
              location.pathname === item.path
                ? "bg-recife-primary text-white"
                : "text-gray-700 hover:bg-recife-primary/10 hover:text-recife-primary"
            )}
          >
            <span className="mr-3">{item.icon}</span>
            {item.title}
          </Link>
        ))}
      </nav>
    </div>
  );
};

export default AdminMenu; 