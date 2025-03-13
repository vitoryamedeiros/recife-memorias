
import React from 'react';
import { Facebook, Instagram, Twitter, Mail } from 'lucide-react';
import { Link } from 'react-router-dom';

const Footer = () => {
  return (
    <footer className="bg-recife-primary text-white mt-16">
      <div className="container mx-auto px-4 py-10">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div>
            <h3 className="text-xl font-bold mb-4">RecifeMemo</h3>
            <p className="text-gray-200 mb-4">
              Preservando a história de Recife através das histórias de seus estudantes.
            </p>
            <div className="flex space-x-4">
              <a 
                href="#" 
                aria-label="Instagram"
                className="text-white hover:text-recife-accent transition-colors"
              >
                <Instagram size={20} />
              </a>
              <a 
                href="#" 
                aria-label="Facebook"
                className="text-white hover:text-recife-accent transition-colors"
              >
                <Facebook size={20} />
              </a>
              <a 
                href="#" 
                aria-label="Twitter"
                className="text-white hover:text-recife-accent transition-colors"
              >
                <Twitter size={20} />
              </a>
            </div>
          </div>
          
          <div>
            <h4 className="text-lg font-semibold mb-4">Links Rápidos</h4>
            <ul className="space-y-2">
              <li>
                <Link to="/" className="text-gray-200 hover:text-white transition-colors">
                  Início
                </Link>
              </li>
              <li>
                <Link to="/locations" className="text-gray-200 hover:text-white transition-colors">
                  Locais Históricos
                </Link>
              </li>
              <li>
                <Link to="/ranking" className="text-gray-200 hover:text-white transition-colors">
                  Ranking
                </Link>
              </li>
              <li>
                <Link to="/dashboard" className="text-gray-200 hover:text-white transition-colors">
                  Dashboard
                </Link>
              </li>
            </ul>
          </div>
          
          <div>
            <h4 className="text-lg font-semibold mb-4">Contato</h4>
            <div className="flex items-center space-x-2 text-gray-200 mb-2">
              <Mail size={18} />
              <span>contato@recifememo.com.br</span>
            </div>
            <p className="text-gray-200">
              Prefeitura do Recife<br />
              Secretaria de Educação<br />
              Av. Cais do Apolo, 925 - Recife, PE
            </p>
          </div>
        </div>
        
        <div className="border-t border-recife-primary-hover mt-8 pt-6 text-center text-gray-300 text-sm">
          <p>© 2024 RecifeMemo. Todos os direitos reservados.</p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
