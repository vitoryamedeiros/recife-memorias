import React, { useState, useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { Menu, X, User, LogOut, Settings, MapPin, PenSquare, Shield, Users, BookOpen, MessageSquare, PieChart } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { 
  DropdownMenu, 
  DropdownMenuContent, 
  DropdownMenuItem, 
  DropdownMenuLabel, 
  DropdownMenuSeparator, 
  DropdownMenuTrigger 
} from '@/components/ui/dropdown-menu';
import { Sheet, SheetContent, SheetTrigger } from '@/components/ui/sheet';
import LoginModal from '@/components/auth/LoginModal';
import { useAuth } from '@/hooks/use-auth';
import { useMobile } from '@/hooks/use-mobile';
import { supabase } from '@/lib/supabase';

const Header = () => {
  const [isLoginModalOpen, setIsLoginModalOpen] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false);
  const { user, signOut } = useAuth();
  const isMobile = useMobile();
  const location = useLocation();
  
  useEffect(() => {
    // Fechar o menu móvel quando a rota muda
    setIsMobileMenuOpen(false);
  }, [location.pathname]);
  
  useEffect(() => {
    // Verificar se o usuário é administrador
    if (user) {
      checkAdminStatus();
    } else {
      setIsAdmin(false);
    }
  }, [user]);
  
  const checkAdminStatus = async () => {
    try {
      const { data, error } = await supabase.rpc('is_admin');
      
      if (error) throw error;
      
      setIsAdmin(!!data);
    } catch (error) {
      console.error('Erro ao verificar status de administrador:', error);
      setIsAdmin(false);
    }
  };
  
  const handleSignOut = async () => {
    try {
      // Limpar o estado antes de fazer logout
      localStorage.removeItem('supabase.auth.token');
      sessionStorage.removeItem('supabase.auth.token');
      
      // Fazer logout
      await signOut();
      
      // Redirecionar para a página inicial
      window.location.href = '/';
    } catch (error) {
      console.error('Erro ao fazer logout:', error);
    }
  };
  
  const getInitials = (name: string) => {
    return name
      .split(' ')
      .map(part => part[0])
      .join('')
      .toUpperCase()
      .substring(0, 2);
  };
  
  const renderAuthSection = () => {
    if (user) {
      return (
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button variant="ghost" className="relative h-10 w-10 rounded-full">
              <Avatar className="h-10 w-10">
                <AvatarImage src={user.user_metadata?.avatar_url} alt={user.user_metadata?.name || user.email} />
                <AvatarFallback>
                  {user.user_metadata?.name
                    ? getInitials(user.user_metadata.name)
                    : user.email?.substring(0, 2).toUpperCase()}
                </AvatarFallback>
              </Avatar>
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end">
            <DropdownMenuLabel>Minha Conta</DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuItem asChild>
              <Link to="/profile" className="cursor-pointer flex items-center">
                <User className="mr-2 h-4 w-4" />
                <span>Perfil</span>
              </Link>
            </DropdownMenuItem>
            <DropdownMenuItem asChild>
              <Link to="/dashboard" className="cursor-pointer flex items-center">
                <PenSquare className="mr-2 h-4 w-4" />
                <span>Minhas Histórias</span>
              </Link>
            </DropdownMenuItem>
            {isAdmin && (
              <>
                <DropdownMenuSeparator />
                <DropdownMenuLabel>Administração</DropdownMenuLabel>
                <DropdownMenuItem asChild>
                  <Link to="/admin/dashboard" className="flex items-center">
                    <Shield className="mr-2 h-4 w-4" />
                    Painel Admin
                  </Link>
                </DropdownMenuItem>
                <DropdownMenuItem asChild>
                  <Link to="/admin/locations" className="flex items-center">
                    <MapPin className="mr-2 h-4 w-4" />
                    Gerenciar Locais
                  </Link>
                </DropdownMenuItem>
                <DropdownMenuItem asChild>
                  <Link to="/admin/stories" className="flex items-center">
                    <BookOpen className="mr-2 h-4 w-4" />
                    Gerenciar Histórias
                  </Link>
                </DropdownMenuItem>
                <DropdownMenuItem asChild>
                  <Link to="/admin/users" className="flex items-center">
                    <Users className="mr-2 h-4 w-4" />
                    Gerenciar Usuários
                  </Link>
                </DropdownMenuItem>
                <DropdownMenuItem asChild>
                  <Link to="/admin/comments" className="flex items-center">
                    <MessageSquare className="mr-2 h-4 w-4" />
                    Gerenciar Comentários
                  </Link>
                </DropdownMenuItem>
                <DropdownMenuItem asChild>
                  <Link to="/admin/reports" className="flex items-center">
                    <PieChart className="mr-2 h-4 w-4" />
                    Relatórios
                  </Link>
                </DropdownMenuItem>
              </>
            )}
            <DropdownMenuSeparator />
            <DropdownMenuItem onClick={handleSignOut} className="cursor-pointer text-red-600">
              <LogOut className="mr-2 h-4 w-4" />
              <span>Sair</span>
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      );
    }
    
    return (
      <Button onClick={() => setIsLoginModalOpen(true)}>Entrar</Button>
    );
  };
  
  const renderMobileMenu = () => {
    return (
      <Sheet open={isMobileMenuOpen} onOpenChange={setIsMobileMenuOpen}>
        <SheetTrigger asChild>
          <Button variant="ghost" size="icon" className="md:hidden">
            <Menu size={24} />
          </Button>
        </SheetTrigger>
        <SheetContent side="left">
          <div className="flex flex-col h-full">
            <div className="flex justify-between items-center py-4">
              <Link to="/" className="text-xl font-bold text-recife-primary">
                RecifeMemo
              </Link>
              <Button variant="ghost" size="icon" onClick={() => setIsMobileMenuOpen(false)}>
                <X size={24} />
              </Button>
            </div>
            
            <nav className="flex flex-col gap-2 py-8">
              <Link
                to="/"
                className="px-4 py-2 hover:bg-gray-100 rounded-md transition-colors"
              >
                Início
              </Link>
              <Link
                to="/locations"
                className="px-4 py-2 hover:bg-gray-100 rounded-md transition-colors"
              >
                Locais
              </Link>
              <Link
                to="/dashboard"
                className="px-4 py-2 hover:bg-gray-100 rounded-md transition-colors"
              >
                Compartilhar História
              </Link>
              {isAdmin && (
                <>
                  <div className="mt-4 mb-2 px-4 text-sm font-semibold text-gray-500">
                    Administração
                  </div>
                  <Link
                    to="/admin/dashboard"
                    className="flex items-center px-4 py-2 text-sm"
                  >
                    <Shield className="mr-2 h-4 w-4" />
                    Painel Admin
                  </Link>
                  <Link
                    to="/admin/locations"
                    className="flex items-center px-4 py-2 text-sm"
                  >
                    <MapPin className="mr-2 h-4 w-4" />
                    Gerenciar Locais
                  </Link>
                  <Link
                    to="/admin/stories"
                    className="flex items-center px-4 py-2 text-sm"
                  >
                    <BookOpen className="mr-2 h-4 w-4" />
                    Gerenciar Histórias
                  </Link>
                  <Link
                    to="/admin/users"
                    className="flex items-center px-4 py-2 text-sm"
                  >
                    <Users className="mr-2 h-4 w-4" />
                    Gerenciar Usuários
                  </Link>
                  <Link
                    to="/admin/comments"
                    className="flex items-center px-4 py-2 text-sm"
                  >
                    <MessageSquare className="mr-2 h-4 w-4" />
                    Gerenciar Comentários
                  </Link>
                  <Link
                    to="/admin/reports"
                    className="flex items-center px-4 py-2 text-sm"
                  >
                    <PieChart className="mr-2 h-4 w-4" />
                    Relatórios
                  </Link>
                </>
              )}
            </nav>
            
            <div className="mt-auto pb-8">
              {!user ? (
                <Button 
                  onClick={() => {
                    setIsMobileMenuOpen(false);
                    setIsLoginModalOpen(true);
                  }}
                  className="w-full"
                >
                  Entrar
                </Button>
              ) : (
                <div className="space-y-4">
                  <div className="flex items-center gap-3 px-4">
                    <Avatar className="h-10 w-10">
                      <AvatarImage src={user.user_metadata?.avatar_url} alt={user.user_metadata?.name || user.email} />
                      <AvatarFallback>
                        {user.user_metadata?.name
                          ? getInitials(user.user_metadata.name)
                          : user.email?.substring(0, 2).toUpperCase()}
                      </AvatarFallback>
                    </Avatar>
                    <div>
                      <p className="font-medium">{user.user_metadata?.name || user.email}</p>
                      <p className="text-sm text-gray-500">{user.email}</p>
                    </div>
                  </div>
                  
                  <div className="grid grid-cols-2 gap-2 px-4">
                    <Link to="/profile">
                      <Button variant="outline" className="w-full">Perfil</Button>
                    </Link>
                    <Button 
                      variant="destructive" 
                      className="w-full"
                      onClick={() => {
                        handleSignOut();
                        setIsMobileMenuOpen(false);
                      }}
                    >
                      Sair
                    </Button>
                  </div>
                </div>
              )}
            </div>
          </div>
        </SheetContent>
      </Sheet>
    );
  };
  
  return (
    <header className="bg-white border-b sticky top-0 z-50">
      <div className="container mx-auto px-4">
        <div className="flex justify-between items-center h-16">
          <div className="flex items-center">
            <Link to="/" className="text-xl font-bold text-recife-primary">
              RecifeMemo
            </Link>
            
            <nav className="hidden md:flex ml-10 space-x-8">
              <Link
                to="/"
                className="text-recife-medium hover:text-recife-primary transition-colors"
              >
                Início
              </Link>
              <Link
                to="/locations"
                className="text-recife-medium hover:text-recife-primary transition-colors"
              >
                Locais
              </Link>
              <Link
                to="/dashboard"
                className="text-recife-medium hover:text-recife-primary transition-colors"
              >
                Compartilhar História
              </Link>
            </nav>
          </div>
          
          <div className="flex items-center space-x-4">
            {renderAuthSection()}
            {isMobile && renderMobileMenu()}
          </div>
        </div>
      </div>
      
      <LoginModal
        isOpen={isLoginModalOpen}
        onClose={() => setIsLoginModalOpen(false)}
      />
    </header>
  );
};

export default Header;
