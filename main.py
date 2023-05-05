import tkinter as tk
from tkinter import ttk
from tkinter import messagebox


class CustomSubWindow:
    # Inheritance is universal - winfo_toplevel is referred i.e. the Toplevel is invoked with the root as the tk_parent
    # Furthermore, its invoked only by TabCustom, not by Main
    def __init__(self, tk_parent, ext_handler):
        self.tk_parent = tk_parent
        # ext_handler is needed to communicate with the parent (invoking) Class, which should be TabCustom
        # It's used to pass the information to fill the listbox (in Tabcustom) upon a button press in this class
        self.ext_handler = ext_handler
        # Main sub_window object that has the root as the parent
        self.sub_window = tk.Toplevel(self.tk_parent.winfo_toplevel())
        self.sub_window.title("Custom VM")
        self.sub_window.geometry('250x250')
        self.ico = tk.PhotoImage(file='icons/1827789.png')
        self.sub_window.iconphoto(False, self.ico)
        # Combobox to choose the vm type
        self.vm_type_str = tk.StringVar()
        self.vm_type = ttk.Combobox(self.sub_window, textvariable=self.vm_type_str, state='readonly')
        self.vm_type.config(values=("Open5Gs", "UERANSIM"))
        self.vm_type.current(0)  # Default value (Open5Gs) to be shown when the box is initialised
        self.vm_type.grid(row=0, column=0)
        # If a selection is made on the combobox, run the _disable_button method that will disable the button if needed
        self.vm_type.bind('<<ComboboxSelected>>', lambda event: self._update_button(event))

        # Checkbutton regarding the optional Mongodb installation. It's disabled if UERANSIM is current combobox value
        self.is_mongodb = tk.BooleanVar()
        self.mongodb_button = tk.Checkbutton(self.sub_window, text="Install mongodb", variable=self.is_mongodb)
        self.mongodb_button.grid(row=1, column=0)

        self.submit_vm = ttk.Button(self.sub_window, text='add vm', command=self._submit_single_vm)
        # ipad extends the button, as it pads internally. Pad pads externally, so the button won't stick to window edges
        self.submit_vm.grid(row=0, column=1, columnspan=2, rowspan=2, ipadx=10, ipady=10, padx=5, pady=2)

        self.custom_config = []

    def _update_button(self, _):
        # First argument is the event that caused the function to be invoked. Not needed in our case, hence we skip it
        if self.vm_type.get() == 'UERANSIM':
            # UERANSIM does not need mongodb in any case, so we disable the button until UERANSIM is deselected
            self.mongodb_button.config(state='disabled')
            self.mongodb_button.deselect()
        else:
            self.mongodb_button.config(state='normal')

    def _submit_single_vm(self):
        self.custom_config.append([self.vm_type_str.get(), self.is_mongodb.get()])
        # Notify the tab parent to update the list with the newly added config element
        self.ext_handler()


class TabPredefined:
    # tk_Parent should be a notebook tab (which is of Frame type)
    # TODO - Maybe a notebook should be the parent?
    def __init__(self, tk_parent: ttk.Frame):
        self.tk_parent = tk_parent
        self.lb = ttk.Label(self.tk_parent, text="Preset", font=('Arial', 16))
        self.lb.grid(row=0, column=0, padx=(10, 0))

        self.chosen_type = tk.StringVar(self.tk_parent)
        # Combobox showing what predefined sim settings are available to choose from
        self.combo = ttk.Combobox(self.tk_parent, textvariable=self.chosen_type, state='readonly', width=35, font=('Arial', 16))
        self.combo.config(values=("Basic setup", "Multiple U-plane's"))
        self.combo.current(0)
        self.combo.grid(row=0, column=1, padx=10, pady=5)
        # Button to submit the current selected sim preset in the combobox
        self.button = ttk.Button(self.tk_parent, text='Submit', command=self._submit_predefined)
        self.button.grid(row=1, column=0, columnspan=2, rowspan=1, padx=10, sticky='nsew')

        self.is_chosen = False

    def _submit_predefined(self):
        # Kills the main window if submit is clicked in this Tab. This ends the mainloop in the grandparent class
        # Also requires to click 'yes' on the popup window, otherwise submit handler will do nothing
        if messagebox.askyesno(title="Confirmation", message="Do you want to submit predefined setup?", icon='warning'):
            self.is_chosen = True
            self.tk_parent.winfo_toplevel().destroy()


class TabCustom:
    # tk_Parent should strictly be a notebook tab (which is of Frame type)
    # TODO - Maybe a notebook should be the parent?
    def __init__(self, tk_parent: ttk.Frame):
        self.tk_parent = tk_parent
        # Button to invoke the custom vm definition window
        self.button = ttk.Button(self.tk_parent, text='add', command=self._add_custom_vm)
        self.button.grid(row=1, column=0)
        # Button to declare that we want to use custom vm deployment with the config specified by the list
        self.button2 = ttk.Button(self.tk_parent, text='submit', command=self._submit_custom)
        self.button2.grid(row=1, column=1)
        # List to indicate added items by the subwindow
        self.list = tk.Listbox(self.tk_parent)
        self.list.insert('1', f'Sim Type; mongodb?')
        self.list.grid(row=0, column=0, columnspan=2, sticky='ew')

        self.is_chosen = False

    # This is invoked only when the button to add a custom VM setting is pressed
    def _add_custom_vm(self):
        # Include the _ext_handler to receive communication from the SubWindow
        self.new_window = CustomSubWindow(self.tk_parent, self._ext_handler)

    def _ext_handler(self):
        # Receive information about new entry and add it to the list to display it
        self.list.insert('end', f'{self.new_window.custom_config[-1][0]}; {self.new_window.custom_config[-1][1]}')

    def _submit_custom(self):
        # Show an error if user wants to submit an empty configuration
        if self.list.index('end') == 1:
            messagebox.showerror(title='Submit error',
                                 message='Can\'t submit empty configuration! Add at least one vm and try again')
        # Kills the main window if submit is clicked in this Tab. This ends the mainloop in the grandparent class
        # Also it's needed to click yes on the popup window
        elif messagebox.askyesno(title="Confirmation", message="Do you want to submit custom setup?", icon='warning'):
            self.is_chosen = True
            self.tk_parent.winfo_toplevel().destroy()


class Notebook:
    # tk_Parent should be the root window
    def __init__(self, tk_parent: tk.Tk, resize_handler):
        self.tk_parent = tk_parent
        self.resize_handler = resize_handler
        self.notebook = ttk.Notebook(self.tk_parent)

        self.tab1 = ttk.Frame(self.notebook)
        self.tab2 = ttk.Frame(self.notebook)

        self.notebook.add(self.tab1, text="Predefined setups")
        self.notebook.add(self.tab2, text="Custom setup")

        self.notebook.pack(expand=True, fill='both')

        self.tab_predefined = TabPredefined(self.tab1)
        self.tab_custom = TabCustom(self.tab2)

        self.notebook.bind('<<NotebookTabChanged>>', self._foo)
        # self.notebook.bind('<ButtonRelease-2>', self._foo)

    def _foo(self, _):
        current_tab = self.notebook.index(self.notebook.select())
        self.resize_handler(current_tab)
        print('bar' + str(current_tab))
        print(f'height: {self.tk_parent.winfo_toplevel().winfo_height()} width: {self.tk_parent.winfo_toplevel().winfo_width()}')


class MainApp:
    # It can be helpful to look at a debug, set with breakpoint at the mainloop to see the class contents
    # Var_dict is passed as an arg to fill its contents with the gathered information from the window
    def __init__(self, var_dict):
        self.root = tk.Tk()
        self.root.resizable(False, False)
        self.root.title("5G simulator vm configurator")
        self.ico = tk.PhotoImage(file='icons/1827789.png')
        self.root.iconphoto(False, self.ico)
        self.notebook = Notebook(self.root, self._resize_handler)
        # self.tab_predefined = TabPredefined(self.notebook.tab1)
        # self.tab_custom = TabCustom(self.notebook.tab2)
        print(f'MainApp height: {self.root.winfo_height()} width: {self.root.winfo_width()}')
        self.root.mainloop()
        self._fill_arr(var_dict)
        # The class ceases to exist at this point unless it's assigned to a variable.

    def _fill_arr(self, var_dict):
        # Populate the passed array with information regarding the GUI execution
        var_dict["custom"] = self.notebook.tab_custom.is_chosen
        var_dict["predefined"] = self.notebook.tab_predefined.is_chosen
        if var_dict["predefined"]:
            var_dict["predefined_type"] = self.notebook.tab_predefined.chosen_type.get()
        if hasattr(self.notebook.tab_custom, 'new_window') and var_dict["custom"]:
            var_dict["custom_type"] = self.notebook.tab_custom.new_window.custom_config

    def _resize_handler(self, current):
        if current == 0:
            self.root.geometry('550x200')
        else:
            self.root.geometry('200x300')


class DisplayApp:
    def __init__(self):
        self.root = tk.Tk()
        self.text = tk.Text(self.root, state='disabled')
        self.text.pack()
        self.root.mainloop()

    def write_line(self, text):
        self.text.configure(state='normal')
        self.text.insert('insert', str(text))
        self.text.configure(state='disabled')


def main():
    retrieved_vars = dict()
    MainApp(retrieved_vars)
    # DisplayApp()
    pass


if __name__ == "__main__":
    main()
